package kr.eddi.demo.member.entity.repository.member;

import kr.eddi.demo.member.entity.member.NextPageMember;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<NextPageMember, Long> {

    @Query("select m from NextPageMember m join fetch m.authentications where m.email = :email")
    Optional<NextPageMember> findByEmail(String email);



}
