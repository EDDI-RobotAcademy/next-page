package kr.eddi.demo.comment;

import kr.eddi.demo.comment.request.CommentModify;
import kr.eddi.demo.comment.request.CommentWrite;
import kr.eddi.demo.episode.NovelEpisodeEntity;
import kr.eddi.demo.episode.NovelEpisodeRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    CommentRepository commentRepository;

    @Autowired
    NovelEpisodeRepository novelEpisodeRepository;

    @Override
    public void commentWrite(CommentWrite commentWrite, Long novelEpisodeNo) {
        Optional<NovelEpisodeEntity> maybeNovelEpisode = novelEpisodeRepository.findById(novelEpisodeNo);
        NovelEpisodeEntity novelEpisodeEntity = maybeNovelEpisode.get();

        CommentEntity commentEntity = new CommentEntity();
        commentEntity.setNovelEpisodeEntity(novelEpisodeEntity);
        commentEntity.setComment(commentWrite.getComment());
        commentEntity.setCommentWriter(commentWrite.getCommentWriter());

        commentRepository.save(commentEntity);

    }

    @Override
    public List<CommentEntity> commentList(Long novelEpisodeNo) {
       return commentRepository.findAllCommentsById(novelEpisodeNo);
    }

    @Override
    public void commentDelete(Long commentNo) {
        commentRepository.deleteById(commentNo);

    }

    @Override
    public void commentModify(Long commentNo, CommentModify commentModify) {
        Optional<CommentEntity> maybeComment = commentRepository.findById(commentNo);
        CommentEntity commentEntity = maybeComment.get();

        commentEntity.modifyComment(commentModify.getComment());

        commentRepository.save(commentEntity);
    }

}
