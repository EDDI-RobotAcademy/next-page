package kr.eddi.demo.episode_payment.repository;

import kr.eddi.demo.episode_payment.entity.EpisodePayment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface EpisodePaymentRepository extends JpaRepository<EpisodePayment, Long>{

    @Query("select ep from EpisodePayment ep join fetch ep.member m join fetch ep.novel n where m.id = :memberId and n.id = :novelId")
    List<EpisodePayment> findEpisodeListByMemberAndNovel(Long memberId, Long novelId);
}
