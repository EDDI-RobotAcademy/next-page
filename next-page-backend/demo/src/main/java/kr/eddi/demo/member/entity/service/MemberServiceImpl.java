package kr.eddi.demo.member.entity.service;


import kr.eddi.demo.member.entity.member.Authentication;
import kr.eddi.demo.member.entity.member.BasicAuthentication;
import kr.eddi.demo.member.entity.member.NextPageMember;
import kr.eddi.demo.member.entity.repository.member.AuthenticationRepository;
import kr.eddi.demo.member.entity.repository.member.MemberRepository;
import kr.eddi.demo.member.entity.service.member.request.MemberSignInRequest;
import kr.eddi.demo.member.entity.service.member.request.MemberSignUpRequest;
import kr.eddi.demo.member.entity.service.security.RedisServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Slf4j
@Service

public class MemberServiceImpl implements MemberService {


    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private AuthenticationRepository authenticationRepository;


    @Autowired
    private RedisServiceImpl redisService;


    @Override
    public Boolean emailValidation(String email) {
        Optional<NextPageMember> maybeMember = memberRepository.findByEmail(email);

        if (maybeMember.isPresent()) {
            return false;
        }

        return true;
    }



    @Override
    public Boolean nickNameValidation (String nickName) {
        Optional<NextPageMember> MemberNickname = memberRepository.findByNickName(nickName);

        if (MemberNickname.isPresent()) {
            return false;
        }

        return true;
    }



    @Override
    public Boolean signUp(MemberSignUpRequest signUpRequest) {
        final NextPageMember member = signUpRequest.toMemberInfo();
        memberRepository.save(member);

        final BasicAuthentication auth = new BasicAuthentication(member,
                Authentication.BASIC_AUTH, signUpRequest.getPassword());

        authenticationRepository.save(auth);

        return true;
    }

    @Override
    public String signIn(MemberSignInRequest signInRequest) {
        String email = signInRequest.getEmail();
        Optional<NextPageMember> maybeMember = memberRepository.findByEmail(email);

        if (maybeMember.isPresent()) {
            NextPageMember memberInfo = maybeMember.get();

            if (!memberInfo.isRightPassword(signInRequest.getPassword())) {
                throw new RuntimeException("잘못된 비밀번호 입니다.");
            }

            UUID userToken = UUID.randomUUID();

            redisService.deleteByKey(userToken.toString());
            redisService.setKeyAndValue(userToken.toString(), memberInfo.getId());

            return userToken.toString();
        }

        throw new RuntimeException("회원가입이 되어있지 않는 회원입니다. ");
    }









}
