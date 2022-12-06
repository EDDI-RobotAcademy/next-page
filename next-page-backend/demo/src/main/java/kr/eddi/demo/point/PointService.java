package kr.eddi.demo.point;

public interface PointService {

    /**
     * 회원 정보와 충전할 포인트를 받아 해당 회원에게 포인트를 추가합니다.
     * @return
     */
    Boolean charge();

}
