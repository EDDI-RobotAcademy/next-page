package kr.eddi.demo.member.form;


import kr.eddi.demo.member.entity.service.member.request.MemberRegisterRequest;
import lombok.Data;


@Data

public class MemberRegisterForm {


    private String email;
    private String password;
    private String nickname;


    public MemberRegisterRequest toMemberRegisterRequest() {
        return new MemberRegisterRequest(email, password, nickname);
    }







}
