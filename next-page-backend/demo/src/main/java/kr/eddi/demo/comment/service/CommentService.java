package kr.eddi.demo.comment.service;

import kr.eddi.demo.comment.request.CommentModifyRequest;
import kr.eddi.demo.comment.request.CommentWriteRequest;

public interface CommentService {
    Boolean commentWrite(CommentWriteRequest commentWriteRequest, Long novelEpisodeNo);
    Boolean commentDelete(Long commentNo);
    Boolean commentModify(Long commentNo, CommentModifyRequest commentModifyRequest);

}
