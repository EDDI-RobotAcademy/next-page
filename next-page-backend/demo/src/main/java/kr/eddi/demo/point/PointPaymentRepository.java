package kr.eddi.demo.point;

import org.springframework.data.jpa.repository.JpaRepository;

public interface PointPaymentRepository extends JpaRepository<PointPayment, Long> {
}
