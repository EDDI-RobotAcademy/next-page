package kr.eddi.demo.comment;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@RequiredArgsConstructor
public class CommentRequest {
    private final Long boardNo;
    private final String commentWriter;
    private final String comment;
}
