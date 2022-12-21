package kr.eddi.demo.comment.request;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CommentModifyRequest {
    private String comment;
}
