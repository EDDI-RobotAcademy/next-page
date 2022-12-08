package kr.eddi.demo.member.entity.service;


import kr.eddi.demo.member.entity.service.member.request.MemberLoginRequest;
import kr.eddi.demo.member.entity.service.member.request.MemberRegisterRequest;

public interface MemberService {

    Boolean emailValidation(String email);

    Boolean nickNameValidation(String nickname);

    Boolean signUp(MemberRegisterRequest request);

    String signIn(MemberLoginRequest request);




}
