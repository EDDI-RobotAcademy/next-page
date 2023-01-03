package kr.eddi.demo.episode_payment;

import kr.eddi.demo.episode_payment.requset.BuyEpisodeRequest;
import kr.eddi.demo.episode_payment.service.EpisodePaymentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/episode-payment")
@Slf4j
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")

public class EpisodePaymentController {

    @Autowired
    EpisodePaymentService service;

    @PostMapping("/buy-episode")
    public Boolean buyEpisode(@RequestBody BuyEpisodeRequest request) {
        log.info("buyEpisode(): " + request);

        return service.buyEpisode(request);
    }
}
