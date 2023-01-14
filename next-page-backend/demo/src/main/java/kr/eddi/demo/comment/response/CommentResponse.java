package kr.eddi.demo.comment.response;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@RequiredArgsConstructor
public class CommentResponse {
    final private Long commentNo;
    final private String comment;
    final private String nickName;
    final private String regDate;
}
