package kr.eddi.demo.comment;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<CommentEntity, Long> {

//    List<CommentEntity> findWebNovelCommentByWebNovel(WebNovelEntity webNovelEntity);

//    JPQL 쿼리 작성
}
