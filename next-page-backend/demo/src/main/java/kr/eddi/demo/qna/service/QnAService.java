package kr.eddi.demo.qna.service;

import kr.eddi.demo.qna.entity.QnA;
import kr.eddi.demo.qna.request.QnARequest;
import kr.eddi.demo.qna.response.QnaResponse;

import java.util.List;

public interface QnAService {


    public Boolean write(QnARequest qnaRequest);

    public QnA read(Long qnaNo);

    public void modify(QnA qna);

    public void remove(Long qnaNo);

    public List<QnaResponse> getQnaListByMemberId(Long memberId);

    List<QnaResponse> getAllQnaList();



}
