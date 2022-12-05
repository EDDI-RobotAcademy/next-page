package kr.eddi.demo.comment;

import java.util.List;

public interface CommentService {
    public void commentWrite(CommentEntity commentEntity, Long boardNo);
    public List<CommentEntity> commentList(Long boardNo);

    public void commentDelete(Long commentNo);

}
