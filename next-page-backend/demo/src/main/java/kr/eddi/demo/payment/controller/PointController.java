package kr.eddi.demo.payment.controller;


import kr.eddi.demo.payment.service.PointServiceImpl;
import kr.eddi.demo.payment.form.PointPaymentForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/point")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class PointController {

    @Autowired
    PointServiceImpl service;

    /**
     * 결제 내역 저장 및 포인트 충전 요청을 받습니다.
     * @return 성공 여부
     */
    @PostMapping("/pay-charge")
    public Boolean payAndCharge(@RequestBody PointPaymentForm pointPaymentForm) {

        return service.paymentAndCharge(pointPaymentForm.toRequest());
    }

}
