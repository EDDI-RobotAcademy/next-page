package kr.eddi.demo.point;

import kr.eddi.demo.member.entity.member.NextPageMember;
import kr.eddi.demo.member.entity.repository.member.MemberRepository;
import kr.eddi.demo.point.request.PointPaymentRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;


@Service
public class PointServiceImpl implements PointService{

    @Autowired
    PointPaymentRepository pointPaymentrepository;

    @Autowired
    MemberRepository memberRepository;


    /**
     * 회원 정보와 충전할 포인트를 받아 해당 회원에게 포인트를 추가합니다.
     * 결제 내역을 회원 정보에 저장합니다.
     * @return 성공 여부
     */
    @Override
    public Boolean paymentAndCharge(PointPaymentRequest request) {

        Optional<NextPageMember> maybeMember = memberRepository.findById(request.getMember_id());

        if(maybeMember.isEmpty()) {
            return false;
        }

        NextPageMember member = maybeMember.get();
        PointPayment pointPayment = request.toEntity(member);

        member.addChargedPoint(pointPayment.getChargedPoint());
        pointPayment.updateToMember();

        pointPaymentrepository.save(pointPayment);
        return true;
    }


}
