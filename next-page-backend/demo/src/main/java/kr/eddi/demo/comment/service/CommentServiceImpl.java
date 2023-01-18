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

    @Autowired
    QnARepository qnaRepository;

    @Autowired
    NovelInformationRepository novelInformationRepository;

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
       episode.getInformation().addCommentCount();

        return true;
    }

    @Override
    @Transactional
    public Boolean qnaCommentWrite(CommentWriteRequest commentWriteRequest, Long QnaNo) {
        Optional<QnA> maybeQnA = qnaRepository.findById(QnaNo);
        if(maybeQnA.isPresent()) {
            QnA qna = maybeQnA.get();

            Optional<NextPageMember> maybeNextPageMember = memberRepository.findById(commentWriteRequest.getCommentWriterId());
            if(maybeNextPageMember.isPresent()) {
                NextPageMember nextPageMember = maybeNextPageMember.get();

                //코멘트 엔티티 생성
                Comment comment = new Comment(commentWriteRequest.getComment(), nextPageMember, qna);
                //qna comment 세팅
                qna.setComment(comment);

                commentRepository.save(comment);
                return true;
            }
            throw new RuntimeException("member 없음");
        }
        throw new RuntimeException("qna 없음");

    }

    @Override
    @Transactional
    public Boolean commentDelete(Long commentNo) {
        Optional<Comment> maybeComment = commentRepository.findById(commentNo);

        if(maybeComment.isPresent()) {
            commentRepository.deleteById(commentNo);
            NovelEpisode maybeNovelEpisode = maybeComment.get().getNovelEpisode();
            // 에피소드 댓글일 경우 해당 소설의 commentCount 값 빼기
            if(maybeNovelEpisode != null) {
                log.info("에피소드 댓글 삭제");
                maybeComment.get().getNovelEpisode().getInformation().minusCommentCount();
                return true;
            }
            log.info("qna 답변 삭제");
            return true;
        }
        throw new RuntimeException("해당 코멘트 없음!");
    }

    @Override
    @Transactional
    public Boolean qnaCommentDelete(Long qnaNo) {
        Optional<QnA> maybeQna = qnaRepository.findById(qnaNo);
        if(maybeQna.isPresent()) {
            commentRepository.deleteById(maybeQna.get().getComment().getCommentNo());
            return true;
        }
        throw new RuntimeException("qna 없음!");
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

    @Override
    @Transactional
    public List<CommentResponse> getCommentListByNovelId(Long novelInfoId) {
        Optional<NovelInformation> maybeNovel = novelInformationRepository.findById(novelInfoId);

        if(maybeNovel.isPresent()) {
            List<NovelEpisode> episodesList = maybeNovel.get().getEpisodeList();
            List<CommentResponse> commentResponseList = new ArrayList<>();

            for(NovelEpisode epi : episodesList) {
               commentResponseList.addAll(getCommentListByEpisodeId(epi.getId()));
            }

            return commentResponseList;

        } throw new RuntimeException("소설 정보 없음!");
    }
}
