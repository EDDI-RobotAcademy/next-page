package kr.eddi.demo.qna.service;


import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.member.repository.MemberRepository;
import kr.eddi.demo.qna.entity.QnA;
import kr.eddi.demo.qna.repository.QnARepository;
import kr.eddi.demo.qna.request.QnARequest;
import kr.eddi.demo.qna.response.QnaResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
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
    public List<QnaResponse> getAllQnaList() {
        List<QnA> qnaList =  qnaRepository.findAll(Sort.by(Sort.Direction.DESC, "qnaNo"));
        List<QnaResponse> qnaResponseList = new ArrayList<>();
        //qna response 객체 생성
        for(QnA qna : qnaList) {
            QnaResponse response = new QnaResponse();
            response.setQnaNo(qna.getQnaNo());
            response.setTitle(qna.getTitle());
            response.setContent(qna.getContent());
            response.setCategory(qna.getCategory());
            response.setRegDate(qna.getRegDate());

            if(qna.getComment() != null) {
                response.setHasComment(true);
                response.setComment(qna.getComment().getComment());
                response.setCommentRegDate(qna.getComment().getCreatedDate());
            } else {
                response.setHasComment(false);
                response.setComment("none");
                response.setCommentRegDate("none");
            }
            qnaResponseList.add(response);
        }
        return qnaResponseList;
    }

    @Override
    public List<QnaResponse> getQnaListByMemberId(Long memberId) {
        Optional<NextPageMember> maybeMember = memberRepository.findById(memberId);

        if(maybeMember.isPresent()) {
            List<QnA> myQnaList = qnaRepository.findQnaListByMemberId(memberId, Sort.by(Sort.Direction.DESC, "qnaNo"));
            List<QnaResponse> qnaResponseList = new ArrayList<>();

            //qna response 객체 생성
            for(QnA qna : myQnaList) {
                QnaResponse response = new QnaResponse();
                        response.setQnaNo(qna.getQnaNo());
                        response.setTitle(qna.getTitle());
                        response.setContent(qna.getContent());
                        response.setCategory(qna.getCategory());
                        response.setRegDate(qna.getRegDate());
                        if(qna.getComment() != null) {
                            response.setHasComment(true);
                            response.setComment(qna.getComment().getComment());
                            response.setCommentRegDate(qna.getComment().getCreatedDate());
                        } else {
                            response.setHasComment(false);
                            response.setComment("none");
                            response.setCommentRegDate("none");
                        }
                        qnaResponseList.add(response);

            }
            return qnaResponseList;
        }
        throw new RuntimeException("해당 멤버가 존재하지 않음.");
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
