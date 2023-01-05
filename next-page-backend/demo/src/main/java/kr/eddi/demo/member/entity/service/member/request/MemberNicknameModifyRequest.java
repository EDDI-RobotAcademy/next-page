package kr.eddi.demo.member.entity.service.member.request;


import kr.eddi.demo.member.entity.member.NextPageMember;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;



@Getter
@ToString
@RequiredArgsConstructor

public class MemberNicknameModifyRequest {

    private Long memberId;

    private String email;

    private String reNickName;

    public NextPageMember toMember(){
        return new NextPageMember(email,reNickName);

    }


}
