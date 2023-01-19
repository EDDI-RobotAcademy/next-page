package kr.eddi.demo.episode_payment.controller;

import kr.eddi.demo.episode_payment.entity.EpisodePayment;
import kr.eddi.demo.episode_payment.requset.BuyEpisodeRequest;
import kr.eddi.demo.episode_payment.requset.GetEpisodeListRequest;
import kr.eddi.demo.episode_payment.requset.GetPurchasedEpisodeRequest;
import kr.eddi.demo.episode_payment.service.EpisodePaymentService;
import kr.eddi.demo.novel.entity.NovelInformation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    @PostMapping("/purchased-episode-list")
    public List<EpisodePayment> getPurchasedEpisodeList(@RequestBody GetEpisodeListRequest request){
        log.info("getPurchasedEpisodeList()");
        log.info("memberId: " + request.getMemberId());
        log.info("novelId: " + request.getNovelId());

        return service.getPurchasedEpisodeList(request);
    }

    @PostMapping("/check-purchased-episode")
    public Boolean checkPurchasedEpisode(@RequestBody GetPurchasedEpisodeRequest request){
        log.info("getPurchasedEpisodeList()");

        log.info("에피소드 구매 여부: " + service.checkPurchasedEpisode(request));

        return service.checkPurchasedEpisode(request);
    }


}
