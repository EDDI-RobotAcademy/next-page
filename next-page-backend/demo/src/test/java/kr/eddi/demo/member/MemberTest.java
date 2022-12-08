package kr.eddi.demo.member;

import kr.eddi.demo.member.entity.service.MemberServiceImpl;
import kr.eddi.demo.member.entity.service.member.request.MemberSignUpRequest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest

public class MemberTest {

    @Autowired
    private MemberServiceImpl service;

    @Test
    void checkEmail() { // 이메일 Test
        boolean Success = service.emailValidation("test1@test.com");
        System.out.println("Success: " + Success);
    }

    @Test
    public void SignUpTest() { // 회원가입 Test
        MemberSignUpRequest request = new MemberSignUpRequest("test@test.com","00000","test");
        boolean Success = service.signUp(request);

        System.out.println(Success);
    }






}
