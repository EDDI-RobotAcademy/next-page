package kr.eddi.demo.episode_payment.requset;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@RequiredArgsConstructor
public class GetEpisodeListRequest {

    final Long memberId;

    final Long novelId;
}
