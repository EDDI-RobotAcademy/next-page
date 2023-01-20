package kr.eddi.demo.rating.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@Getter
@ToString
public class StarRating {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long starRatingNo;

    @Column(nullable = false)
    private Long novelId;

    @Column(nullable = false)
    private Long memberId;

    @Column
    private int starRating;

    public StarRating(Long novelId, Long memberId, int starRating) {
        this.novelId = novelId;
        this.memberId = memberId;
        this.starRating = starRating;
    }

    public void modifyStarRating(int newStarRating){
        this.starRating = newStarRating;
    }

}
