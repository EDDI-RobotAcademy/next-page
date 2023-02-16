package kr.eddi.demo;

import kr.eddi.demo.notice.entity.Notice;
import kr.eddi.demo.notice.request.WriteNoticeRequest;
import kr.eddi.demo.notice.service.NoticeService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

@SpringBootTest
public class NoticeTestCase {
//    @Autowired
//    NoticeService noticeService;
//
//    @Test
//    void writeNoticeTest() {
//        WriteNoticeRequest request = new WriteNoticeRequest(
//                "공지테스트 일반", "됴됴됴됴됴", "일반", 2L);
//
//        System.out.println(noticeService.writeNotice(request));
//    }
//
//    @Test
//    void deleteNoticeTest() {
//        Boolean result = noticeService.deleteNotice(13L);
//        System.out.println(result);
//    }
//
//    @Test
//    void getNoticeListTest() {
//        PageRequest pageRequest = PageRequest.of(0,3);
//        Page<Notice> noticePage = noticeService.getNoticeListFindByNovelInfoId(2L, pageRequest);
//        System.out.println(noticePage);
//    }
}
