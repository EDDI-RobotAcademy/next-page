package kr.eddi.demo.notice.request;

import kr.eddi.demo.notice.entity.Notice;
import kr.eddi.demo.notice.entity.NoticeCategory;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
@Getter
@ToString
@RequiredArgsConstructor
public class WriteNoticeRequest {
    final private String title;
    final private String content;
    final private String noticeCategory;
    final private Long novelInfoId;

    public Notice toEntity() {
        NoticeCategory category =
                switch (noticeCategory) {
                    case "이벤트" -> NoticeCategory.EVENT;
                    case "휴재" -> NoticeCategory.REST;
                    case "일반" -> NoticeCategory.COMMON;
                    default -> null;
                };

        return new Notice(title, content, category, novelInfoId);
    }
}
