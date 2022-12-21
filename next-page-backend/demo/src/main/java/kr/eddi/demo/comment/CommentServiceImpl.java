package kr.eddi.demo.comment;

import kr.eddi.demo.comment.request.CommentModifyRequest;
import kr.eddi.demo.comment.request.CommentWriteRequest;
import kr.eddi.demo.member.entity.member.NextPageMember;
import kr.eddi.demo.member.entity.repository.member.MemberRepository;
import kr.eddi.demo.novel.entity.NovelEpisode;
import kr.eddi.demo.novel.repository.NovelEpisodeRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
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
    public Boolean commentWrite(CommentWriteRequest commentWriteRequest, Long novelEpisodeNo) {

        Optional<NovelEpisode> maybeNovelEpisode = novelEpisodeRepository.findById(novelEpisodeNo);
        if(maybeNovelEpisode.isEmpty()) {
            return false;
        }
        NovelEpisode episode = maybeNovelEpisode.get();

        Optional<NextPageMember> maybeNextPageMember = memberRepository.findById(commentWriteRequest.getCommentWriterId());
        if(maybeNextPageMember.isEmpty()) {
            return false;
        }
        NextPageMember nextPageMember = maybeNextPageMember.get();

        //코멘트 엔티티 생성
        Comment comment = new Comment(commentWriteRequest.getComment(), nextPageMember, episode);

        commentRepository.save(comment);

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

}
