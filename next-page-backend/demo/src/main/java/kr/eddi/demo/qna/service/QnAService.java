package kr.eddi.demo.qna.service;

import kr.eddi.demo.qna.entity.QnA;
import kr.eddi.demo.qna.request.QnARequest;

import java.util.List;

public interface QnAService {


    public void write(QnARequest qnaRequest);

    public List<QnA> list();

    public QnA read(Long qnaNo);

    public void modify(QnA qna);

    public void remove(Long qnaNo);



}
