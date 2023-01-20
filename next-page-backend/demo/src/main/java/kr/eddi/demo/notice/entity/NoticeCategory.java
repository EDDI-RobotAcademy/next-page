package kr.eddi.demo.notice.entity;

import lombok.RequiredArgsConstructor;
import lombok.ToString;

@ToString
@RequiredArgsConstructor
public enum NoticeCategory {
        COMMON("일반"),
        EVENT("이벤트"),
        REST("휴재");

    private final String NoticeCategory;
}
