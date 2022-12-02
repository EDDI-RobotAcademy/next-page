package kr.eddi.demo.comment;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentRepository extends JpaRepository<CommentEntity, Long> {

//    JPQL 쿼리 작성
}
