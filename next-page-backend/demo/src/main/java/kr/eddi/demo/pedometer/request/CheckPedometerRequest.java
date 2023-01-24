package kr.eddi.demo.pedometer.request;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CheckPedometerRequest {

    private String nowDate;

    private Long id;
}
