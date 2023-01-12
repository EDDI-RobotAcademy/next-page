package kr.eddi.demo;

import kr.eddi.demo.qna.entity.QnA;
import kr.eddi.demo.qna.repository.QnARepository;
import kr.eddi.demo.qna.request.QnARequest;
import kr.eddi.demo.qna.response.QnaResponse;
import kr.eddi.demo.qna.service.QnAService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class QnaTestCase {

    @Autowired
    QnAService qnAService;

    @Test
    public void writeQna() {
        QnARequest req = new QnARequest(10L, "테스트 qna2", "소설 문의", "와랄라라라랄라");

        Boolean result = qnAService.write(req);
        System.out.println("qna write test result: " + result.toString());
    }

    @Test
    public void getMyQnaList() {
        List<QnaResponse> myQnaList = qnAService.getQnaListByMemberId(10L);

        System.out.println(myQnaList);
    }
}
