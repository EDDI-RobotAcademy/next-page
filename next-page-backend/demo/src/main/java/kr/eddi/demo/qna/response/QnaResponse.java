package kr.eddi.demo.qna.response;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QnaResponse {
    Long qnaNo;
    String title;
    String category;
    String content;
    Date regDate;
    Boolean hasComment;
    String comment;
}
