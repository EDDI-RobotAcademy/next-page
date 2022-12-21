package kr.eddi.demo.comment.request;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CommentWriteRequest {
    private Long commentWriterId;
    private String comment;
}
