package kr.eddi.demo.comment.repository;

import kr.eddi.demo.comment.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentRepository extends JpaRepository<Comment, Long> {

}
