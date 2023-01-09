package kr.eddi.demo.member.request;


import kr.eddi.demo.member.entity.NextPageMember;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;



@Getter
@ToString
@RequiredArgsConstructor

public class MemberSignUpRequest {


    private final String email;
    private final String password;
    private final String nickName;



    public NextPageMember toMemberInfo(){
        return new NextPageMember(email,nickName);
    }






}