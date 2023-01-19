package kr.eddi.demo.qna.repository;

import kr.eddi.demo.qna.entity.QnA;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


public interface QnARepository  extends JpaRepository<QnA, Long> {
    List<QnA> findQnaListByMemberId(Long memberId, Sort sort);






}
