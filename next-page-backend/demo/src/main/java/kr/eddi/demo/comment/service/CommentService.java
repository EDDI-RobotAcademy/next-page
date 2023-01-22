package kr.eddi.demo.comment.service;

import kr.eddi.demo.comment.response.CommentAndEpisodeResponse;
import kr.eddi.demo.comment.response.CommentResponse;
import kr.eddi.demo.comment.request.CommentModifyRequest;
import kr.eddi.demo.comment.request.CommentWriteRequest;

import java.util.List;

public interface CommentService {
    Boolean commentWrite(CommentWriteRequest commentWriteRequest, Long novelEpisodeNo);
    Boolean commentDelete(Long commentNo);

    Boolean qnaCommentDelete(Long qnaNo);

    Boolean commentModify(Long commentNo, CommentModifyRequest commentModifyRequest);

    Boolean qnaCommentWrite(CommentWriteRequest commentWriteRequest, Long qnaNo);

    List<CommentResponse> getCommentListByEpisodeId(Long episodeId);

    List<CommentAndEpisodeResponse> getCommentListByNovelId(Long novelInfoId);

    List<CommentAndEpisodeResponse> getCommentListByMemberId(Long memberId);

}
