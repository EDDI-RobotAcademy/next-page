package kr.eddi.demo.point.form;


import lombok.Data;

@Data
public class PointPaymentForm {

    private Long member_id;
    private Long payment_id;
    private Long amount;
    private Long point;

    // TODO: 2022.12.2 PointPaymentRequest로 변환 이루어져야함

}
