package kr.eddi.demo.qna.service;


import kr.eddi.demo.qna.entity.QnA;
import kr.eddi.demo.qna.repository.QnARepository;
import kr.eddi.demo.qna.request.QnARequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service

public class QnAServiceImpl implements QnAService {


    @Autowired
    QnARepository repository;

    @Override
    public void write(QnARequest qnaRequest) {
        QnA qna = new QnA();
        qna.setTitle(qnaRequest.getTitle());
        qna.setContent(qnaRequest.getContent());
        qna.setCategory(qnaRequest.getCategory());

        repository.save(qna);
    }

    @Override
    public List<QnA> list() {
        return repository.findAll(Sort.by(Sort.Direction.DESC, "qnaNo"));
    }

    @Override
    public QnA read(Long qnaNo) {
        Optional<QnA> maybeBoard = repository.findById(Long.valueOf(qnaNo));

        if (maybeBoard.equals(Optional.empty())) {
            log.info("Can't read board!!!");
            return null;
        }

        return maybeBoard.get();

    }

    @Override
    public void modify(QnA qna) {
        repository.save(qna);
    }

    @Override
    public void remove(Long qnaNo) {
        repository.deleteById(qnaNo);
    }





}
