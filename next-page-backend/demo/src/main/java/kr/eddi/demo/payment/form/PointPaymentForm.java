package kr.eddi.demo.payment.form;


import kr.eddi.demo.payment.request.PointPaymentRequest;
import lombok.Data;

@Data
public class PointPaymentForm {

    private Long member_id;
    private Long payment_id;
    private Long amount;
    private Long point;

    // TODO: 2022.12.2 PointPaymentRequest로 변환 이루어져야함

    public PointPaymentRequest toRequest() {
        return new PointPaymentRequest(member_id, payment_id, amount, point );
    }
}
