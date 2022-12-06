package kr.eddi.demo.member.entity.service.member.request;

import kr.eddi.demo.member.entity.member.MemberProfile;
import kr.eddi.demo.member.entity.member.NextPageMember;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;


@Getter
@ToString
@RequiredArgsConstructor
@Slf4j

public class MemberRegisterRequest {


    private final String email;
    private final String password;
    private final String nickname;


    public NextPageMember toMember() {

        MemberProfile profile = new MemberProfile();

        if (nickname == null || nickname.length() == 0) {

            log.info("nickname is empty");

            return new NextPageMember(
                    this.email,
                    profile.builder()
                            .nickName(this.email)
                            .build()
            );
        }


        log.info("nickname isn't empty");

        return new NextPageMember(
                this.email,
                profile.builder()
                        .nickName(this.nickname)
                        .build());
    }



}
