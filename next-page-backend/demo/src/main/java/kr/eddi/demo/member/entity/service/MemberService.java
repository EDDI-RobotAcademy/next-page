package kr.eddi.demo.member.entity.service;


import kr.eddi.demo.member.entity.service.member.request.MemberRegisterRequest;

public interface MemberService {

    Boolean emailValidation(String email);

    Boolean signUp(MemberRegisterRequest request);




}
