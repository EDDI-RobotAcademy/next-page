package kr.eddi.demo.rating.repository;

import kr.eddi.demo.rating.entity.StarRating;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface StarRatingRepository extends JpaRepository<StarRating, Long> {

    @Query("select s from StarRating s where s.memberId = :memberId and s.novelId = :novelId")
    Optional<StarRating> findByMemberIdAndNovelId(Long memberId, Long novelId);
}
