package kr.eddi.demo.rating.controller;

import kr.eddi.demo.comment.request.CommentModifyRequest;
import kr.eddi.demo.rating.request.AddStarRatingRequest;
import kr.eddi.demo.rating.request.CheckRatingRequest;
import kr.eddi.demo.rating.service.StarRatingService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/rating")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class StarRatingController {

    @Autowired
    StarRatingService service;

   /* //소설에 별점을 주는 기능
    @PostMapping("/add-rating")
    public Boolean addStarRating(@RequestBody AddStarRatingRequest request) {
        log.info("addStarRating()");

        return service.addStarRatingToNovel(request);
    }

    //소설에 내가 별점을 준 기록이 있는지 체크하는 기능
    @PostMapping("/check-my-rating")
    public int checkMyStarRating(@RequestBody CheckRatingRequest request) {
        log.info("checkMyStarRating()");
        log.info("checkMyStarRating() request.memberId" + request.getMemberId());
        log.info("checkMyStarRating() request.novelId" + request.getNovelId());

        return service.checkRatingToNovel(request);
    }

    @PutMapping("/modify-rating")
    public Boolean modifyStarRating (@RequestBody AddStarRatingRequest request) {
        log.info("modifyStarRating()");

        return service.modifyStarRatingToNovel(request);
    }*/
}
