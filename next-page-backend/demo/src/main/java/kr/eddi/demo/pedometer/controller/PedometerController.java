package kr.eddi.demo.pedometer.controller;
import kr.eddi.demo.pedometer.request.CheckPedometerRequest;
import kr.eddi.demo.pedometer.service.PedometerService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/pedometer")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class PedometerController {

    @Autowired
    PedometerService service;

    @PostMapping("/check/today")
    public Boolean checkTodayPedometer(@RequestBody CheckPedometerRequest request) {
        log.info("checkTodayPedometer()");
        log.info("checkTodayPedometer() created_datd: " +request.getNowDate());
        log.info("checkTodayPedometer() memberId : " +request.getId().toString());

        return service.checkIsTaken(request);
    }

    @GetMapping("/get-point/{memberId}")
    public void getPointByPedometer(@PathVariable("memberId") Long memberId) {
        log.info("getPointByPedometer(): " + memberId);

        service.getPointByPedometer(memberId);
    }
}
