package kr.eddi.demo.rating.request;

import kr.eddi.demo.rating.entity.StarRating;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AddStarRatingRequest {

    private Long novelId;
    private Long memberId;
    private int starRating;

    public StarRating toEntity() {
        return new StarRating(novelId,memberId, starRating);
    }

}
