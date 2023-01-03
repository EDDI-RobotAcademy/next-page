package kr.eddi.demo.episode_payment.repository;

import kr.eddi.demo.episode_payment.entity.EpisodePayment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EpisodePaymentRepository extends JpaRepository<EpisodePayment, Long>{
}
