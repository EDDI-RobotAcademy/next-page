package kr.eddi.demo.member.request;



import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@RequiredArgsConstructor

public class MemberPasswordModifyRequest {

    private final Long memberId;
    private final String newPassword;

}
