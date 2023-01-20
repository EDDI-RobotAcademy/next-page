package kr.eddi.demo.rating.request;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CheckRatingRequest {

    private Long novelId;
    private Long memberId;
}
