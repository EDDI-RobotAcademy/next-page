package kr.eddi.demo;


import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.member.repository.MemberRepository;
import kr.eddi.demo.member.request.MemberPointRequest;
import kr.eddi.demo.member.service.MemberServiceImpl;

import kr.eddi.demo.member.request.MemberPasswordModifyRequest;
import kr.eddi.demo.member.request.MemberSignInRequest;
import kr.eddi.demo.member.request.MemberSignUpRequest;
import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.transaction.Transactional;
import java.util.Map;
import java.util.Optional;

@SpringBootTest

public class MemberTest {

    @Autowired
    private MemberServiceImpl service;


    @Autowired
    private MemberRepository repository;

    @Test
    void checkEmail() { // 이메일 Test
        boolean Success = service.emailValidation(""); // 중복 체크 이메일
        System.out.println("Success: " + Success);
    }


    @Test
    public void nickNameCheck() { //닉네임 Test
        boolean Success = service.nickNameValidation(""); // 중복 체크 닉네임
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
        MemberSignInRequest request = new MemberSignInRequest("test@test.com", "00000000");
        Map<String, String> memberInfo = service.signIn(request);
        String token = memberInfo.get("userToken");
        System.out.println(token);

    }


    @Test
    public void deleteMember() { // 회원탈퇴 Test
        Long userId = Long.valueOf(""); // 탈퇴할 멤버 ID 번호
        service.deleteMember(userId);

    }


    @Test
    public void modifyNickName() { // 닉네임 Test

        String reNickName = ""; // 변경할 닉네임
        Long memberId = 9L; // 변경할 닉네임 멤버 ID 번호

        if (service.nickNameValidation(reNickName)) {

            Optional<NextPageMember> mayMember = repository.findById(memberId);
            if (mayMember.isEmpty()) {
                System.out.println("회원 정보를 찾을 수 없습니다");
            }
            NextPageMember member = mayMember.get();
            member.setNickName(reNickName);

            repository.save(member);
            System.out.println("닉네임이 변경 되었습니다. : " + member.getNickName());

        } else {

            System.out.println("중복된 닉네임 입니다. ");
        }

    }


    @Test
    public void modifyPassword() { // 비밀번호 Test

        MemberPasswordModifyRequest request = new MemberPasswordModifyRequest(9L, "00000000");
        boolean Success = service.modifyPassword(request);

        System.out.println("Success : 비밀번호를 변경 완료 하였습니다. " + Success);

    }

//    @Test
//    public void findMemberPoint() {
//        MemberPointRequest pointRequest = new MemberPointRequest(1L);
//
//        System.out.println("memberPoint: " + service.findMemberPoint(pointRequest));
//    }




}
