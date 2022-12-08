package kr.eddi.demo.point;

import kr.eddi.demo.point.request.PointPaymentRequest;

public interface PointService {

    Boolean paymentAndCharge(PointPaymentRequest request);
}
