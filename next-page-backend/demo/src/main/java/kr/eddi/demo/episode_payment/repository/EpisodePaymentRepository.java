package kr.eddi.demo.episode_payment.repository;

import kr.eddi.demo.episode_payment.entity.EpisodePayment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface EpisodePaymentRepository extends JpaRepository<EpisodePayment, Long>{

    @Query("select ep from EpisodePayment ep join fetch ep.member m join fetch ep.novel n where m.id = :memberId and n.id = :novelId")
    List<EpisodePayment> findEpisodeListByMemberAndNovel(Long memberId, Long novelId);

    @Query("select ep from EpisodePayment ep join fetch ep.member m  where m.id = :memberId and ep.episodeId = :episodeId")
    Optional<EpisodePayment> findEpisodePaymentByMemberAndEpisodeId(Long memberId, Long episodeId);
}
