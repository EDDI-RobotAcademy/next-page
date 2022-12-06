package kr.eddi.demo.member;

import kr.eddi.demo.member.entity.service.MemberServiceImpl;
import kr.eddi.demo.member.entity.service.member.request.MemberRegisterRequest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest

public class MemberTest {

    @Autowired
    private MemberServiceImpl service;

    @Test
    void checkEmail() { // 이메일 Test
        boolean Success = service.emailValidation("test@test.com");
        System.out.println("Success: " + Success);
    }


    @Test
    void signUpTest() { // 회원가입 Test
        MemberRegisterRequest request = new MemberRegisterRequest("test@test.com", "00000", "test");
        boolean Success = service.signUp(request);
        System.out.println("Success: " + Success);
    }





}
