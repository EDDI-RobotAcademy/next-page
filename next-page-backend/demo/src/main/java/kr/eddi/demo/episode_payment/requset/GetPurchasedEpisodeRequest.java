package kr.eddi.demo.episode_payment.requset;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@RequiredArgsConstructor
public class GetPurchasedEpisodeRequest {
    private Long memberId;

    private Long episodeId;
}
