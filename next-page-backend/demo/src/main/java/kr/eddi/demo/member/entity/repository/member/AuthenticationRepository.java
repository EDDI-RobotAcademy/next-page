package kr.eddi.demo.member.entity.repository.member;

import kr.eddi.demo.member.entity.member.Authentication;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuthenticationRepository extends JpaRepository<Authentication, Long> {



}
