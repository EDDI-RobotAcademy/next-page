package kr.eddi.demo.member.entity.service.member.request;


import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;



@Getter
@ToString
@RequiredArgsConstructor

public class MemberNicknameModifyRequest {

    private Long memberId;

    private String reNickName;

}
