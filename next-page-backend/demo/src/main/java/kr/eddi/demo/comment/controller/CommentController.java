package kr.eddi.demo.comment.controller;

import kr.eddi.demo.comment.service.CommentService;
import kr.eddi.demo.comment.request.CommentModifyRequest;
import kr.eddi.demo.comment.request.CommentWriteRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/comment")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class CommentController {

    @Autowired
    CommentService commentService;


    @PostMapping("/write/{novelEpisodeNo}")
    public void commentWrite(@PathVariable("novelEpisodeNo") Long novelEpisodeNo, @RequestBody CommentWriteRequest commentWriteRequest) {
        log.info("writeComment()");

        commentService.commentWrite(commentWriteRequest, novelEpisodeNo);
    }

    @DeleteMapping("/{commentNo}")
    public void commentDelete (@PathVariable("commentNo") Long commentNo) {
        log.info("commentDelete()");

        commentService.commentDelete(commentNo);
    }

    @PutMapping("/{commentNo}")
    public void commentModify (@PathVariable("commentNo") Long commentNo, @RequestBody CommentModifyRequest commentModifyRequest) {
        log.info("commentModifyRequest()");

        commentService.commentModify(commentNo, commentModifyRequest);
    }


}
