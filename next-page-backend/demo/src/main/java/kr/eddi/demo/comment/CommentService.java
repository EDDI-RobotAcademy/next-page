package kr.eddi.demo.comment;

import java.util.List;

public interface CommentService {
    public void commentWrite(CommentRequest commentRequest);
    public List<CommentEntity> commentList(Long boardNo);

}
