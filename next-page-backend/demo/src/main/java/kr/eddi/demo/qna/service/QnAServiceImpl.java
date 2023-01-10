package kr.eddi.demo.qna.service;


import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.member.repository.MemberRepository;
import kr.eddi.demo.qna.entity.QnA;
import kr.eddi.demo.qna.repository.QnARepository;
import kr.eddi.demo.qna.request.QnARequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@Transactional

public class QnAServiceImpl implements QnAService {


    @Autowired
    QnARepository qnaRepository;

    @Autowired
    MemberRepository memberRepository;

    @Override
    public Boolean write(QnARequest qnaRequest) {
        Optional<NextPageMember> maybeMember = memberRepository.findById(qnaRequest.getMemberId());

        if(maybeMember.isPresent()) {
            NextPageMember member = maybeMember.get();

            QnA qna = new QnA();
            qna.setTitle(qnaRequest.getTitle());
            qna.setContent(qnaRequest.getContent());
            qna.setCategory(qnaRequest.getCategory());
            qna.setMember(member);
            qna.updateToMember();

            qnaRepository.save(qna);
            return true;
        }
        throw new RuntimeException("해당 멤버가 존재하지 않음.");
    }

    @Override
    public List<QnA> list() {
        return qnaRepository.findAll(Sort.by(Sort.Direction.DESC, "qnaNo"));
    }

    @Override
    public QnA read(Long qnaNo) {
        Optional<QnA> maybeBoard = qnaRepository.findById(Long.valueOf(qnaNo));

        if (maybeBoard.equals(Optional.empty())) {
            log.info("Can't read board!!!");
            return null;
        }

        return maybeBoard.get();

    }

    @Override
    public void modify(QnA qna) {
        qnaRepository.save(qna);
    }

    @Override
    public void remove(Long qnaNo) {
        qnaRepository.deleteById(qnaNo);
    }





}
