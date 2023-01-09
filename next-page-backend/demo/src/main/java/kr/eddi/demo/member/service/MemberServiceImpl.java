package kr.eddi.demo.member.service;


import kr.eddi.demo.member.request.MemberPointRequest;
import kr.eddi.demo.security.entity.Authentication;
import kr.eddi.demo.security.entity.BasicAuthentication;
import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.security.repository.AuthenticationRepository;
import kr.eddi.demo.member.repository.MemberRepository;
import kr.eddi.demo.member.request.MemberPasswordModifyRequest;
import kr.eddi.demo.member.request.MemberSignInRequest;
import kr.eddi.demo.member.request.MemberSignUpRequest;
import kr.eddi.demo.security.service.RedisServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Slf4j
@Service
@Transactional

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
    public Boolean nickNameValidation(String nickName) {
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
    public Map<String, String> signIn(MemberSignInRequest signInRequest) {
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

            Map<String, String> userInfo = new HashMap<>();

            userInfo.put("userToken", userToken.toString());
            userInfo.put("userEmail", memberInfo.getEmail());
            userInfo.put("userNickName", memberInfo.getNickName());
            userInfo.put("userPoint", memberInfo.getPoint().toString());
            userInfo.put("userId", memberInfo.getId().toString());

            log.info("userProfile()" + userInfo);


            return userInfo;
        }

        throw new RuntimeException("회원가입이 되어있지 않는 회원입니다. ");
    }


    @Override
    public void deleteMember(Long userId) {

        Optional<NextPageMember> maybeMember = memberRepository.findById(userId);

        if (maybeMember.isPresent()) {

            NextPageMember member = maybeMember.get();

            memberRepository.delete(member);

        }

    }


    @Override
    public String modifyNickName(Long memberId, String reNickName) {


        String msg = "msg";
        if (nickNameValidation(reNickName)) {

            Optional<NextPageMember> maybeMember = memberRepository.findById(memberId);

            if (maybeMember.isEmpty()) {

                msg = "회원정보를 찾을수 없습니다.";
                return msg;

            }
            NextPageMember member = maybeMember.get();
            member.setNickName(reNickName);


            memberRepository.save(member);
            msg = "닉네임 변경 되었습니다.";
        } else {
            msg = "중복된 닉네임 입니다.";
        }

        return msg;
    }



    @Override
    public Boolean modifyPassword(MemberPasswordModifyRequest request) {

        Optional<NextPageMember> maybeMember = memberRepository.findById(request.getMemberId());

        if (maybeMember.isPresent()) {

            final NextPageMember member = maybeMember.get();

            final Optional<Authentication> mayAuth = authenticationRepository.findByMemberId(request.getMemberId());

            if (mayAuth.isPresent()) {

                mayAuth.get().getId();
                authenticationRepository.deleteById(mayAuth.get().getId());

                final BasicAuthentication auth = new BasicAuthentication(member,Authentication.BASIC_AUTH,request.getNewPassword());
                authenticationRepository.save(auth);

            }

        }

        return true;

    }
    @Override
    public Long findMemberPoint(MemberPointRequest memberPointRequest) {
        Long memberId = memberPointRequest.getMemberId();
        Optional<NextPageMember> maybeMember = memberRepository.findById(memberId);

        if(maybeMember.isPresent()) {
            Long memberPoint = maybeMember.get().getPoint();
            return memberPoint;
        }
        throw new RuntimeException("회원 정보 없음");
    }



}



