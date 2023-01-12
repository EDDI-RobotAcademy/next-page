package kr.eddi.demo;

import kr.eddi.demo.episode_payment.requset.BuyEpisodeRequest;
import kr.eddi.demo.episode_payment.service.EpisodePaymentService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class EpisodePaymentTest {

    @Autowired
    EpisodePaymentService episodePaymentService;
    // 테스트할 때 꼭! 소설등록, 에피소드 등록 먼저 해야합니다!!
    @Test
    void buyEpisodeTest() {
        BuyEpisodeRequest req = new BuyEpisodeRequest(3L, 18L, 5L);
        episodePaymentService.buyEpisode(req);
    }
}
