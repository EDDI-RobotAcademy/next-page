package kr.eddi.demo.rating.service;

import kr.eddi.demo.rating.request.AddStarRatingRequest;
import kr.eddi.demo.rating.request.CheckRatingRequest;

public interface StarRatingService {

    Boolean addStarRatingToNovel(AddStarRatingRequest request);

    int checkRatingToNovel(CheckRatingRequest request);

    /*Boolean modifyStarRatingToNovel(AddStarRatingRequest request);*/

}
