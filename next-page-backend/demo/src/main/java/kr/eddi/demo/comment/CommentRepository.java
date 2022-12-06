package kr.eddi.demo.comment;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface CommentRepository extends JpaRepository<CommentEntity, Long> {
    @Query("select c from CommentEntity c join c.novelEpisodeEntity n where n.novelEpisodeNo = :novelEpisodeNo")
    List<CommentEntity> findAllCommentsById(Long novelEpisodeNo);
}
