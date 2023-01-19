package kr.eddi.demo.qna.response;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QnaResponse {
    Long qnaNo;
    String title;
    String category;
    String content;
    String regDate;
    Boolean hasComment;
    String comment;
    String commentRegDate;
}
