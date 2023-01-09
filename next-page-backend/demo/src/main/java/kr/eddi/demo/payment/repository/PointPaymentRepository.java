package kr.eddi.demo.payment.repository;

import kr.eddi.demo.payment.entity.PointPayment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PointPaymentRepository extends JpaRepository<PointPayment, Long> {
}
