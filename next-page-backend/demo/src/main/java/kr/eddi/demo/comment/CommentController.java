package kr.eddi.demo.comment;

import kr.eddi.demo.comment.request.CommentModify;
import kr.eddi.demo.comment.request.CommentWrite;
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


    @PostMapping("/write/{novelEpisodeNo}")
    public void commentWrite(@PathVariable("novelEpisodeNo") Long novelEpisodeNo, @RequestBody CommentWrite commentWrite) {
        log.info("writeComment()");

        commentService.commentWrite(commentWrite, novelEpisodeNo);
    }

    @GetMapping("/list/{novelEpisodeNo}")
    public List<CommentEntity> commentList (@PathVariable("novelEpisodeNo") Long novelEpisodeNo){
        log.info("commentList()");

        return commentService.commentList(novelEpisodeNo);
    }

    @DeleteMapping("/{commentNo}")
    public void commentDelete (@PathVariable("commentNo") Long commentNo) {
        log.info("commentDelete()");

        commentService.commentDelete(commentNo);
    }

    @PutMapping("/{commentNo}")
    public void commentModify (@PathVariable("commentNo") Long commentNo, @RequestBody CommentModify commentModify) {
        log.info("commentModify()");

        commentService.commentModify(commentNo, commentModify);
    }


}
