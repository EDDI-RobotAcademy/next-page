package kr.eddi.demo.comment;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/comment")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class CommentController {

    @Autowired
    CommentService commentService;


    @PostMapping("/write/{boardNo}")
    public void commentWrite(@RequestBody CommentRequest commentRequest) {
        log.info("writeComment()");

    }

    @GetMapping("/list/{boardNo}")
    public List<CommentEntity> commentList (@PathVariable("boardNo") Long boardNo){
        log.info("commentList()");

        return null;
    }

    @DeleteMapping("/{commentNo}")
    public void commentDelete (@PathVariable("commentNo") Long commentNo, CommentEntity commentEntity) {
        log.info("commentDelete()");

        commentService.commentDelete(commentNo);
    }

    //@PutMapping 수정 컨트롤러


}
