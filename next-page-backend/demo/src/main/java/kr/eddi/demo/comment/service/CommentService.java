package kr.eddi.demo.comment.service;

import kr.eddi.demo.comment.response.CommentResponse;
import kr.eddi.demo.comment.request.CommentModifyRequest;
import kr.eddi.demo.comment.request.CommentWriteRequest;

import java.util.List;

public interface CommentService {
    Boolean commentWrite(CommentWriteRequest commentWriteRequest, Long novelEpisodeNo);
    Boolean commentDelete(Long commentNo);
    Boolean commentModify(Long commentNo, CommentModifyRequest commentModifyRequest);

    Boolean qnaCommentWrite(CommentWriteRequest commentWriteRequest, Long QnaNo);

    List<CommentResponse> getCommentListByEpisodeId(Long episodeId);

}
