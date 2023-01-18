package kr.eddi.demo.rating.service;

import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.novel.repository.NovelInformationRepository;
import kr.eddi.demo.rating.entity.StarRating;
import kr.eddi.demo.rating.repository.StarRatingRepository;
import kr.eddi.demo.rating.request.AddStarRatingRequest;
import kr.eddi.demo.rating.request.CheckRatingRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@Slf4j
public class StarRatingServiceImpl implements StarRatingService {

    @Autowired
    NovelInformationRepository informationRepository;

    @Autowired
    StarRatingRepository ratingRepository;

    @Override
    public Boolean addStarRatingToNovel(AddStarRatingRequest request){
        Optional<NovelInformation> maybeNovel = informationRepository.findById(request.getNovelId());

        if(maybeNovel.isPresent()){
            NovelInformation novel = maybeNovel.get();
            novel.addTotalStarRating(request.getStarRating());
            novel.addRatingCount();
            informationRepository.save(novel);
            StarRating rating = request.toEntity();
            ratingRepository.save(rating);
            return true;
        } else {
            return false;
        }
    }

    @Override
    public int checkRatingToNovel(CheckRatingRequest request){
        Optional<StarRating> maybeRating = ratingRepository.findByMemberIdAndNovelId(request.getMemberId(), request.getNovelId());

        if(maybeRating.isPresent()){
            return maybeRating.get().getStarRating();
        } else{
            return 0;
        }
    }

    @Override
    public Boolean modifyStarRatingToNovel(AddStarRatingRequest request){
        Optional<StarRating> maybeRating = ratingRepository.findByMemberIdAndNovelId(request.getMemberId(), request.getNovelId());
        Optional<NovelInformation> maybeNovel = informationRepository.findById(request.getNovelId());

        if(maybeRating.isPresent()){
            NovelInformation novel = maybeNovel.get();
            StarRating rating = maybeRating.get();
            //기존 별점 만큼 먼저 빼고
            novel.minusTotalStarRating(rating.getStarRating());

            //새 별점 만큼 다시 더한다 , 카운트는 그대로
            novel.addTotalStarRating(request.getStarRating());
            informationRepository.save(novel);
            rating.modifyStarRating(request.getStarRating());
            ratingRepository.save(rating);
            return true;
        } else {
            return false;
        }
    }


}
