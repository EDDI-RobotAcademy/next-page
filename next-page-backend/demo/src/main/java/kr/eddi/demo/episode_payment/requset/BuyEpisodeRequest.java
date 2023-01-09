package kr.eddi.demo.episode_payment.requset;

import kr.eddi.demo.episode_payment.entity.EpisodePayment;
import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.novel.entity.NovelEpisode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@RequiredArgsConstructor
public class BuyEpisodeRequest {
    final Long memberId;
    // 에피소드 회차가 아닌 고유 id값 입니다.
    final Long episodeId;

    public EpisodePayment toEntity(NextPageMember member, NovelEpisode episode) {
        return new EpisodePayment(member, episode);
    }
}
