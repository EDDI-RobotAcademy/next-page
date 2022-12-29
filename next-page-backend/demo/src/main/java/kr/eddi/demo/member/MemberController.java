package kr.eddi.demo.member;


import kr.eddi.demo.member.entity.member.NextPageMember;
import kr.eddi.demo.member.entity.service.MemberServiceImpl;
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
    public Map<String,String> SignIn(@RequestBody MemberSignInForm Form) {
        log.info("SignIn: " + Form);

        return service.signIn(Form.toMemberSignInRequest());
    }




}
