package kr.eddi.demo.member;


import kr.eddi.demo.member.entity.service.MemberServiceImpl;
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
        log.info("EmailCheck()");

        return service.emailValidation(email);
    }

    @PostMapping("/sign-up")
    public Boolean signUp(@RequestBody MemberRegisterForm form){ // 회원가입
        log.info("signup: " + form);

        return service.signUp(form.toMemberRegisterRequest());
    }



}
