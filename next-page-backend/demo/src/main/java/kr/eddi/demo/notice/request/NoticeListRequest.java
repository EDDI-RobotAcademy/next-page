package kr.eddi.demo.notice.request;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@ToString
@Getter
@RequiredArgsConstructor
public class NoticeListRequest {

    final private Long novelInfoId;
    final private int page;
    final private int size;

}
