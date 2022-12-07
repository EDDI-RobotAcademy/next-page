package kr.eddi.demo.member.entity.service;


import kr.eddi.demo.member.entity.member.Authentication;
import kr.eddi.demo.member.entity.member.BasicAuthentication;
import kr.eddi.demo.member.entity.member.NextPageMember;
import kr.eddi.demo.member.entity.repository.member.AuthenticationRepository;
import kr.eddi.demo.member.entity.repository.member.MemberRepository;
import kr.eddi.demo.member.entity.service.member.request.MemberLoginRequest;
import kr.eddi.demo.member.entity.service.member.request.MemberRegisterRequest;
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
    public Boolean nickNameValidation(String nickname) {
        Optional<NextPageMember> maybeMember = memberRepository.findByNickname(nickname);

        if (maybeMember.isPresent()) {
            return false;
        }

        return true;
    }



    @Override
    public Boolean signUp(MemberRegisterRequest request) {

        final NextPageMember member = request.toMember();
        memberRepository.save(member);

        final BasicAuthentication auth = new BasicAuthentication(member,
                Authentication.BASIC_AUTH, request.getPassword());

        authenticationRepository.save(auth);

        return true;
    }


    @Override
    public String signIn(MemberLoginRequest request) {

        String email = request.getEmail();
        Optional<NextPageMember> maybeMember = memberRepository.findByEmail(email);

        if(maybeMember.isPresent()) {
          NextPageMember member = maybeMember.get();

            if(!member.isRightPassword(request.getPassword())) {
                throw new RuntimeException("패스워드가 잘못되었습니다. ");
            }

            UUID userToken = UUID.randomUUID();

            redisService.deleteByKey(userToken.toString());
            redisService.setKeyAndValue(userToken.toString(), member.getId());

            return userToken.toString();

        }
        throw new RuntimeException("가입된 사용자가 아닙니다.");
    }



}
