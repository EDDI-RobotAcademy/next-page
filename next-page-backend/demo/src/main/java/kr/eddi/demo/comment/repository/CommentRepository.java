package kr.eddi.demo.comment.repository;

import kr.eddi.demo.comment.entity.Comment;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    @Query("select c from Comment c join c.novelEpisode tb where tb.id = :episodeId")
    List<Comment> findCommentListByEpisodeId(Long episodeId, Sort sort);

}
