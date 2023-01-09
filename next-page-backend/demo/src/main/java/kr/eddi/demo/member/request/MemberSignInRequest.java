package kr.eddi.demo.member.request;


import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@RequiredArgsConstructor

public class MemberSignInRequest {

    private final String email;
    private final String password;

}
