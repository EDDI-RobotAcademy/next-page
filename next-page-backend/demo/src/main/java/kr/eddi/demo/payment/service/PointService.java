package kr.eddi.demo.payment.service;

import kr.eddi.demo.payment.request.PointPaymentRequest;

public interface PointService {

    Boolean paymentAndCharge(PointPaymentRequest request);
}
