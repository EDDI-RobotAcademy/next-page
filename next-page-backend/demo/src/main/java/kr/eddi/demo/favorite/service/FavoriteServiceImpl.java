package kr.eddi.demo.favorite.service;

import kr.eddi.demo.favorite.entity.Favorite;
import kr.eddi.demo.favorite.repository.FavoriteRepository;
import kr.eddi.demo.favorite.request.FavoriteRequest;
import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.member.repository.MemberRepository;
import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.novel.repository.NovelInformationRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@Transactional
public class FavoriteServiceImpl implements FavoriteService {

    @Autowired
    FavoriteRepository favoriteRepository;

    @Autowired
    MemberRepository memberRepository;

    @Autowired
    NovelInformationRepository novelRepository;

    public Boolean pushLike(FavoriteRequest pushLikeRequest) {
        Optional<NextPageMember> maybeMember = memberRepository.findById(pushLikeRequest.getMemberId());
        Optional<NovelInformation> maybeNovel = novelRepository.findById(pushLikeRequest.getNovelId());

        if(maybeMember.isPresent() && maybeNovel.isPresent()) {
           Optional<Favorite> maybeFavorite = favoriteRepository.
                   findByNovelAndMember(pushLikeRequest.getNovelId(), pushLikeRequest.getMemberId());

           if(maybeFavorite.isPresent()) {
               log.info("찜 기록 있음");
               Boolean isLike = maybeFavorite.get().getIsLike();

               if(isLike) {
                   // 이미 찜 눌렀으면 false로 변경 후 false 리턴
                   log.info("찜 된 상태");
                   maybeFavorite.get().setIsLike(false);
                   return false;
               } else {
                   // 찜 상태 false면 다시 true로 변경
                   log.info("찜 해제 상태");
                   maybeFavorite.get().setIsLike(true);
                   return true;
               }
           } else {
               log.info("찜기록 없음");

               Favorite favorite = new Favorite();
               favorite.setIsLike(true);
               favorite.setMember(maybeMember.get());
               favorite.setNovel(maybeNovel.get());
               favoriteRepository.save(favorite);
               maybeMember.get().updateInterestList(favorite);
               maybeNovel.get().updateInterestList(favorite);
               return true;
           }
        }
        throw new RuntimeException("멤버나 노벨 없음!");
    }
    @Override
    public Boolean getLikeStatus(FavoriteRequest likeStatusRequest){
        Optional<NextPageMember> maybeMember = memberRepository.findById(likeStatusRequest.getMemberId());
        Optional<NovelInformation> maybeNovel = novelRepository.findById(likeStatusRequest.getNovelId());

        if(maybeMember.isPresent() && maybeNovel.isPresent()) {
            Optional<Favorite> maybeFavorite = favoriteRepository.
                    findByNovelAndMember(likeStatusRequest.getNovelId(), likeStatusRequest.getMemberId());

            if(maybeFavorite.isPresent()) {
                log.info("찜 기록 있음");
                Boolean isLike = maybeFavorite.get().getIsLike();
                if(isLike) {
                    log.info("찜 된 상태");
                    return true;
                } else {
                    log.info("찜 해제 상태");
                    return false;
                }
            } else {
                log.info("찜 기록 없음");
                return false;
            }
        }
        throw new RuntimeException("찜 기록 없음");
    }
    @Override
    public List<Long> getLikeNovelIdList(Long memberId){
        Optional<NextPageMember> maybeMember = memberRepository.findById(memberId);

        if(maybeMember.isPresent()) {
            List<Favorite> favoriteLikeList = favoriteRepository.findByFavoriteByMemberId(memberId);
            List<Long> likeNovelIdList = new ArrayList<>();

            for(Favorite f : favoriteLikeList) {
                likeNovelIdList.add(f.getNovel().getId());
            }
            return likeNovelIdList;
        }
        throw new RuntimeException("멤버 없음!");
    }
}
