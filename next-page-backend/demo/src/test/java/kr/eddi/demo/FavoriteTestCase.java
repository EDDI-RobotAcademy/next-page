package kr.eddi.demo;

import kr.eddi.demo.favorite.request.FavoriteRequest;
import kr.eddi.demo.favorite.service.FavoriteService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class FavoriteTestCase {

    @Autowired
    FavoriteService favoriteService;

    @Test
    void pushFavoriteTest() {
        FavoriteRequest req = new FavoriteRequest(1L, 3L);
        System.out.println(favoriteService.pushLike(req));
    }

    @Test
    void getLikeStatusTest() {
        FavoriteRequest req = new FavoriteRequest(1L, 1L);
        System.out.println(favoriteService.getLikeStatus(req));
    }

    @Test
    void getLikeNovelIdList() {
        System.out.println(favoriteService.getLikeNovelIdList(1L));
    }

}
