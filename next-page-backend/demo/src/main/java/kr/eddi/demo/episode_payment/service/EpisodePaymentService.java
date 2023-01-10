package kr.eddi.demo.episode_payment.service;

import kr.eddi.demo.episode_payment.requset.BuyEpisodeRequest;
import kr.eddi.demo.episode_payment.requset.GetEpisodeListRequest;

import java.util.List;

public interface EpisodePaymentService {
    Boolean buyEpisode(BuyEpisodeRequest buyRequest);

    List getPurchasedEpisodeList(GetEpisodeListRequest request);
}
