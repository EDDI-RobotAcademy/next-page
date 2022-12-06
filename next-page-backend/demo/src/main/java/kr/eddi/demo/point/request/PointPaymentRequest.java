package kr.eddi.demo.point.request;


import kr.eddi.demo.member.entity.member.NextPageMember;
import kr.eddi.demo.point.PointPayment;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class PointPaymentRequest {

    private final Long member_id;
    private final Long payment_id;
    private final Long amount;
    private final Long point;


    /**
     * request를 entity로 변환합니다.
     * service 쪽 메소드에서 request를 받은 후 메소드 내에서 entity로 변환하기 위해 만들었습니다.
     * @param member 위의 member_id로 찾은 회원 정보
     * @return 변환된 entity
     */
    public PointPayment toEntity(NextPageMember member) {
        return new PointPayment(member, payment_id, amount, point);
    }

}
