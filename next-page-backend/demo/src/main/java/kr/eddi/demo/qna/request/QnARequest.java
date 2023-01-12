package kr.eddi.demo.qna.request;


import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@RequiredArgsConstructor
public class QnARequest {

    final private Long memberId;
    final private String title;
    final private String category;
    final private String content;






}
