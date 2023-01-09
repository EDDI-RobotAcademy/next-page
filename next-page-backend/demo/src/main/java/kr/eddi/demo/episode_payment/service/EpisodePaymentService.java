package kr.eddi.demo.episode_payment.service;

import kr.eddi.demo.episode_payment.requset.BuyEpisodeRequest;

public interface EpisodePaymentService {
    Boolean buyEpisode(BuyEpisodeRequest buyRequest);
}
