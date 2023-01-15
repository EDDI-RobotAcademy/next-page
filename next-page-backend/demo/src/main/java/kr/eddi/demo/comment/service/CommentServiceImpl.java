package kr.eddi.demo.comment.service;

import kr.eddi.demo.comment.response.CommentResponse;
import kr.eddi.demo.comment.entity.Comment;
import kr.eddi.demo.comment.repository.CommentRepository;
import kr.eddi.demo.comment.request.CommentModifyRequest;
import kr.eddi.demo.comment.request.CommentWriteRequest;
import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.member.repository.MemberRepository;
import kr.eddi.demo.novel.entity.NovelEpisode;
import kr.eddi.demo.novel.repository.NovelEpisodeRepository;
import kr.eddi.demo.qna.entity.QnA;
import kr.eddi.demo.qna.repository.QnARepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    CommentRepository commentRepository;

    @Autowired
    MemberRepository memberRepository;

    @Autowired
    NovelEpisodeRepository novelEpisodeRepository;

    @Override
    @Transactional
    public Boolean commentWrite(CommentWriteRequest commentWriteRequest, Long novelEpisodeId) {

        Optional<NovelEpisode> maybeNovelEpisode = novelEpisodeRepository.findById(novelEpisodeId);
        if(maybeNovelEpisode.isEmpty()) {
            log.info("에피소드 없음");
            return false;
        }
        NovelEpisode episode = maybeNovelEpisode.get();

        Optional<NextPageMember> maybeNextPageMember = memberRepository.findById(commentWriteRequest.getCommentWriterId());
        if(maybeNextPageMember.isEmpty()) {
            log.info("멤버 없음");
            return false;
        }
        NextPageMember nextPageMember = maybeNextPageMember.get();

        //코멘트 엔티티 생성
        Comment comment = new Comment(commentWriteRequest.getComment(), nextPageMember, episode);

        commentRepository.save(comment);
        //novel information 댓글 카운트 추가
       episode.getInformation().updateCommentCount();

        return true;
    }



    @Override
    public Boolean commentDelete(Long commentNo) {
        commentRepository.deleteById(commentNo);
        return true;
    }

    @Override
    @Transactional
    public Boolean commentModify(Long commentNo, CommentModifyRequest commentModifyRequest) {
        Optional<Comment> maybeComment = commentRepository.findById(commentNo);
        if(maybeComment.isEmpty()) {
            return false;
        }
        Comment comment = maybeComment.get();

        comment.modifyComment(commentModifyRequest.getComment());
        comment.updateToEpisode();

        commentRepository.save(comment);
        return true;
    }

    @Override
    @Transactional
    public List<CommentResponse> getCommentListByEpisodeId(Long episodeId) {

        Optional<NovelEpisode> maybeEpisode = novelEpisodeRepository.findById(episodeId);
        if(maybeEpisode.isPresent()) {
            List<Comment> comments = commentRepository.findCommentListByEpisodeId(episodeId);
            List<CommentResponse> commentResponses = new ArrayList<>();

            for(Comment c : comments) {
                CommentResponse commentResponse = new CommentResponse(
                                                        c.getCommentNo(),
                                                        c.getComment(),
                                                        c.getMember().getNickName(),
                                                        c.getCreatedDate());
                commentResponses.add(commentResponse);
            }
            return commentResponses;
        }
        throw new RuntimeException("에피소드 없음!");
    }
}
