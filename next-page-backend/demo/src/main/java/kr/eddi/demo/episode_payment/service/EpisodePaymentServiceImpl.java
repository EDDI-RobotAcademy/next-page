package kr.eddi.demo.episode_payment.service;

import kr.eddi.demo.episode_payment.entity.EpisodePayment;
import kr.eddi.demo.episode_payment.repository.EpisodePaymentRepository;
import kr.eddi.demo.episode_payment.requset.BuyEpisodeRequest;
import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.member.repository.MemberRepository;
import kr.eddi.demo.novel.entity.NovelEpisode;
import kr.eddi.demo.novel.repository.NovelEpisodeRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

@Slf4j
@Service
@Transactional
public class EpisodePaymentServiceImpl implements EpisodePaymentService{
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    NovelEpisodeRepository episodeRepository;
    @Autowired
    EpisodePaymentRepository episodePaymentRepository;

    @Override
    public Boolean buyEpisode(BuyEpisodeRequest buyRequest) {
        Optional<NextPageMember> maybeMember = memberRepository.findById(buyRequest.getMemberId());
        Optional<NovelEpisode> maybeEpisode = episodeRepository.findById(buyRequest.getEpisodeId());

        if(maybeMember.isPresent() && maybeEpisode.isPresent()) {
            NextPageMember member = maybeMember.get();
            NovelEpisode episode = maybeEpisode.get();

            Long memberPoint = member.getPoint();
            Long episodePrice = episode.getInformation().getPurchasePoint();

            if(memberPoint < episodePrice) {
                log.info("포인트 부족으로 구매 실패");
                return false;
            }
            // 에피소드 가격만큼 사용자의 포인트를 차감합니다.
            member.payPoint(episodePrice);

            EpisodePayment episodePayment = buyRequest.toEntity(member, episode);
            episodePayment.updateToMember();
            episodePayment.updateToEpisode();

            episodePaymentRepository.save(episodePayment);
            return true;

        }
        throw new RuntimeException("존재하지 않는 회원 혹은 존재하지 않는 에피소드");
    }
}
