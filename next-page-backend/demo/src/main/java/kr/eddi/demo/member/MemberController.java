package kr.eddi.demo.member;


import kr.eddi.demo.member.entity.service.MemberServiceImpl;
import kr.eddi.demo.member.form.MemberLoginForm;
import kr.eddi.demo.member.form.MemberRegisterForm;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/member")

public class MemberController {

    @Autowired
    MemberServiceImpl service;

    @GetMapping("/check-email/{email}") //이메일 체크
    public Boolean emailValidation(@PathVariable("email") String email) {
        log.info("EmailCheck()" + email);

        return service.emailValidation(email);
    }


    @PostMapping("/check-nickname/{nickname}") // 닉네임 체크
    public Boolean nicknameValidation(@PathVariable("nickname") String nickname) {
        log.info("nicknameCheck(): " + nickname);

        return service.nickNameValidation(nickname);
    }


    @PostMapping("/sign-up") // 회원가입
    public Boolean signUp(@RequestBody MemberRegisterForm form){
        log.info("signup: " + form);

        return service.signUp(form.toMemberRegisterRequest());
    }

    @PostMapping("/log-in") // 로그인
    public String signIn(@RequestBody MemberLoginForm form) {
        log.info("signin:" + form);

        return service.signIn(form.toMemberLoginRequest());
    }





}
