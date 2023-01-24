package kr.eddi.demo.favorite.repository;

import kr.eddi.demo.favorite.entity.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface FavoriteRepository extends JpaRepository<Favorite, Long> {

    @Query("select f from Favorite f join fetch f.novel fn join fetch f.member fm where fn.id = :novelId and fm.id= :memberId")
    Optional<Favorite> findByNovelAndMember(Long novelId, Long memberId);

    @Query("select f from Favorite f join fetch f.novel fn join fetch f.member fm where fm.id= :member_id and f.isLike = true" )
    List<Favorite> findByFavoriteByMemberId(Long member_id);

}
