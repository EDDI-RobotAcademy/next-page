package kr.eddi.demo.member.form;


import kr.eddi.demo.member.request.MemberSignInRequest;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@NoArgsConstructor
public class MemberSignInForm {


    private String email;
    private String password;

    public MemberSignInRequest toMemberSignInRequest(){
        return new MemberSignInRequest(email, password);
    }


}
