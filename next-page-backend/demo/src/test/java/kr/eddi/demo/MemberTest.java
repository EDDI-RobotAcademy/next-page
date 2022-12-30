package kr.eddi.demo;

import kr.eddi.demo.member.entity.member.NextPageMember;
import kr.eddi.demo.member.entity.service.MemberServiceImpl;
import kr.eddi.demo.member.entity.service.member.request.MemberSignInRequest;
import kr.eddi.demo.member.entity.service.member.request.MemberSignUpRequest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.transaction.Transactional;
import java.util.Map;

@SpringBootTest

public class MemberTest {

    @Autowired
    private MemberServiceImpl service;

    @Test
    void checkEmail() { // 이메일 Test
        boolean Success = service.emailValidation("");
        System.out.println("Success: " + Success);
    }


    @Test
    public void nickNameCheck() { //닉네임 Test
        boolean Success = service.nickNameValidation("");
        System.out.println("Success: " + Success);
    }


    @Test
    public void SignUpTest() { // 회원가입 Test
        MemberSignUpRequest request = new MemberSignUpRequest("", "", "");
        boolean Success = service.signUp(request);
        System.out.println("Success: " + Success);
    }


    @Test
    @Transactional

    public void SignInTest() {  // 로그인 Test
        MemberSignInRequest request = new MemberSignInRequest("", "");
        Map<String, String> memberInfo = service.signIn(request);
        String token = memberInfo.get("userToken");
        System.out.println(token);

    }


    @Test
    public void deleteMember() { // 회원탈퇴 Test

        Long userId = Long.valueOf("");
        service.deleteMember(userId);


    }

}
