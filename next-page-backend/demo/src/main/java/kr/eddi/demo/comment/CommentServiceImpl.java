package kr.eddi.demo.comment;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    CommentRepository commentRepository;

    @Override
    public void commentWrite(CommentRequest commentRequest) {

    }

    @Override
    public List<CommentEntity> commentList(Long boardNo) {
        return null;
    }

}
