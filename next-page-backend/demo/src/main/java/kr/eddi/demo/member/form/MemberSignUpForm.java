package kr.eddi.demo.member.form;


import kr.eddi.demo.member.entity.service.member.request.MemberSignUpRequest;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@NoArgsConstructor
public class MemberSignUpForm {


    private String email;
    private String password;
    private String nickName;


    public MemberSignUpRequest toMemberSignUpRequest(){
        return new MemberSignUpRequest(email, password, nickName);
    }



}
