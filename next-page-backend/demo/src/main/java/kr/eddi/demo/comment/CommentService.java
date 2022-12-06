package kr.eddi.demo.comment;

import kr.eddi.demo.comment.request.CommentModify;
import kr.eddi.demo.comment.request.CommentWrite;

import java.util.List;

public interface CommentService {
    public void commentWrite(CommentWrite commentWrite, Long novelEpisodeNo);
    public List<CommentEntity> commentList(Long novelEpisodeNo);
    public void commentDelete(Long commentNo);
    public void commentModify(Long commentNo, CommentModify commentModify);

}
