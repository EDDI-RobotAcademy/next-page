package kr.eddi.demo.favorite.controller;

import kr.eddi.demo.favorite.request.FavoriteRequest;
import kr.eddi.demo.favorite.service.FavoriteService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/favorite")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class FavoriteController {

    @Autowired
    FavoriteService favoriteService;

    @GetMapping("/like-novel-list/{memberId}")
    public List<Long> getLikeNovelIdList(@PathVariable("memberId") Long memberId){
        log.info("getLikeNovelIdList(): " + memberId);

        return favoriteService.getLikeNovelIdList(memberId);
    }

    @PostMapping("/push-like")
    public Boolean pushLike(@RequestBody FavoriteRequest pushLikeRequest){
        log.info("pushLike(): " + pushLikeRequest);

        return favoriteService.pushLike(pushLikeRequest);
    }

    @PostMapping("/like-status")
    public Boolean getLikeStatus(@RequestBody FavoriteRequest likeStatusRequest){
        log.info("getLikeStatus(): " + likeStatusRequest);

        return favoriteService.getLikeStatus(likeStatusRequest);
    }
}
