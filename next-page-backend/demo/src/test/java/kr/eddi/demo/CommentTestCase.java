package kr.eddi.demo;


import kr.eddi.demo.comment.CommentServiceImpl;
import kr.eddi.demo.comment.request.CommentModifyRequest;
import kr.eddi.demo.comment.request.CommentWriteRequest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class CommentTestCase {

    @Autowired
    CommentServiceImpl commentService;

    @Test
    void commentWriteTest() {
        CommentWriteRequest commentWriteRequest = new CommentWriteRequest(1L, "재밌어요");
        Boolean isOk = commentService.commentWrite(commentWriteRequest, 1L );
        System.out.println("isOk?: " + isOk);
    }

    @Test
    void commentModifyTest() {
        CommentModifyRequest modify = new CommentModifyRequest("수정완료");
        Boolean isOk = commentService.commentModify(1l, modify);
        System.out.println("isOk?: " + isOk);
    }

    @Test
    void commentDeleteTest() {
        Boolean isOk = commentService.commentDelete(1L);
        System.out.println("isOk: " + isOk);
    }

}
