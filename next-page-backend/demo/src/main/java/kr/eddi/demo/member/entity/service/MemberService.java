package kr.eddi.demo.member.entity.service;


import kr.eddi.demo.member.entity.service.member.request.MemberPasswordModifyRequest;
import kr.eddi.demo.member.entity.service.member.request.MemberSignInRequest;
import kr.eddi.demo.member.entity.service.member.request.MemberSignUpRequest;

import java.util.Map;

public interface MemberService {

    Boolean emailValidation(String email);

    Boolean nickNameValidation(String nickName);

    Boolean signUp(MemberSignUpRequest signUpRequest);

    Map<String, String> signIn(MemberSignInRequest signInRequest);

    void deleteMember(Long userId);

    String modifyNickName(Long memberId, String reNickName);

    Boolean modifyPassword(MemberPasswordModifyRequest request);

}
