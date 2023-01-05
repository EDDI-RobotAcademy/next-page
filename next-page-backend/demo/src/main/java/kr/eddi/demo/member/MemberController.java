package kr.eddi.demo.member;


import kr.eddi.demo.member.entity.service.MemberServiceImpl;
import kr.eddi.demo.member.entity.service.member.request.MemberNicknameModifyRequest;
import kr.eddi.demo.member.entity.service.member.request.MemberPasswordModifyRequest;
import kr.eddi.demo.member.entity.service.member.request.MemberSignInRequest;
import kr.eddi.demo.member.entity.service.member.request.MemberSignUpRequest;
import kr.eddi.demo.member.form.MemberSignInForm;
import kr.eddi.demo.member.form.MemberSignUpForm;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/member")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")

public class MemberController {

    @Autowired
    MemberServiceImpl service;

    @PostMapping("/check-email/{email}") //이메일 체크
    public Boolean emailValidation(@PathVariable("email") String email) {
        log.info("EmailCheck()" + email);

        return service.emailValidation(email);
    }


    @PostMapping("/check-nickname/{nickName}") //닉네임 체크
    public Boolean nickNameValidation(@PathVariable("nickName") String nickName) {
        log.info("nickName :" + nickName);

        return service.nickNameValidation(nickName);
    }


    @PostMapping("/sign-up") // 회원가입
    public Boolean signUp(@RequestBody MemberSignUpForm form) {
        log.info("signup: " + form);

        return service.signUp(form.toMemberSignUpRequest());
    }

    @PostMapping("/sign-in") // 로그인
    public Map<String, String> SignIn(@RequestBody MemberSignInForm Form) {
        log.info("SignIn: " + Form);

        return service.signIn(Form.toMemberSignInRequest());
    }


    @DeleteMapping("/member-delete/{userId}") // 회원 탈퇴
    public void memberDelete(@PathVariable("userId") Long userId) {
        log.info("memberDelete" + userId);

        service.deleteMember(userId);
    }


    @PostMapping("/modify-nickName") // 닉네임 수정

    public String modifyNickName(@RequestBody MemberNicknameModifyRequest memberNicknameModifyRequest) {

        log.info("닉네임 변경 멤버 아이디 : " + memberNicknameModifyRequest.getMemberId());
        log.info("변경할 닉네임 : " + memberNicknameModifyRequest.getReNickName());

        Long memberId = memberNicknameModifyRequest.getMemberId();
        String reNickName = memberNicknameModifyRequest.getReNickName();

        return service.modifyNickName(memberId, reNickName);
    }



    @PostMapping("/modify-password") // 비밀번호 수정

    public Boolean modifyPassword(@RequestBody MemberPasswordModifyRequest request) {


        log.info("비밀번호 수정 : " + request);

        return service.modifyPassword(request);

    }


}
