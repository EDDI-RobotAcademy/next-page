package kr.eddi.demo.comment;

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

//    웹소설 repository
//    @Autowired
//    WebNovelRepository webNovelRepository;

//    자유게시판 repository
//    @Autowired
//    FreeBoardRepository freeBoardRepository;

    @Override
    public void commentWrite(CommentEntity commentEntity, Long boardNo) {
//        Optional<WebNovelEntity> findWebNovel = webNovelRepository.findById(boardNo);
//
//        commentEntity.setWebNovelEntity(findWebNovel.get());
//        commentRepository.save(commentEntity);

    }

    @Override
    public List<CommentEntity> commentList(Long boardNo) {
//        CommentEntity commentEntity = webNovelRepository.findById(boardNo).get();
//
//        return commentRepository.findWebNovelCommentByWebNovel(webNovelEntity);
        return null;

    }

    @Override
    public void commentDelete(Long commentNo) {
        commentRepository.deleteById(Long.valueOf(commentNo));

    }

}
