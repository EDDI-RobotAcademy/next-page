package kr.eddi.demo.pedometer.service;

import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.member.repository.MemberRepository;
import kr.eddi.demo.pedometer.entity.Pedometer;
import kr.eddi.demo.pedometer.repository.PedometerRepository;
import kr.eddi.demo.pedometer.request.CheckPedometerRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@Slf4j
public class PedometerServiceImpl implements PedometerService{

    @Autowired
    PedometerRepository pedometerRepository;

    @Autowired
    MemberRepository memberRepository;


    /**
     * 오늘의 만보기 포인트 수령 여부를 확인합니다.
     * @param
     * @return Boolean
     */
    @Transactional
    @Override
    public Boolean checkIsTaken(CheckPedometerRequest request) {

            Optional<Pedometer> maybePedometer =
                    pedometerRepository.findByMemberIdAndAndCreatedDate(request.getId(), request.getNowDate());
            if (maybePedometer.isPresent()) {
                log.info("오늘은 이미 포인트 수령했음.");
                return true;
            } else {
                log.info("오늘 포인트를 수령하지 않았음 개꿀!.");
                return false;
            }
    }

    @Transactional
    @Override
    public void getPointByPedometer(Long memberId){
        Optional<NextPageMember> maybeMember = memberRepository.findById(memberId);

        if(maybeMember.isPresent()){
            NextPageMember member = maybeMember.get();

            Pedometer pedometer = new Pedometer(member);
            member.addChargedPoint(300L);
            pedometerRepository.save(pedometer);
        }
    }
}
