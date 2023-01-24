package kr.eddi.demo.pedometer.repository;

import kr.eddi.demo.pedometer.entity.Pedometer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;


public interface PedometerRepository extends JpaRepository<Pedometer, Long> {

    @Query("select p from Pedometer p join fetch p.member m where m.id = :id and p.createdDate = :createdDate")
    Optional<Pedometer> findByMemberIdAndAndCreatedDate(Long id, String createdDate);
}
