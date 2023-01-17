package kr.eddi.demo.notice.service;

import kr.eddi.demo.notice.entity.Notice;
import kr.eddi.demo.notice.request.WriteNoticeRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

public interface NoticeService {
    // 전체 공지 읽기(페이징)
    Page<Notice> getNoticeListFindByNovelInfoId(Long novelInfoId, PageRequest pageRequest);

    // 쓰기
    Boolean writeNotice(WriteNoticeRequest writeNoticeRequest);

    // 삭제
    Boolean deleteNotice(Long noticeNo);
}
