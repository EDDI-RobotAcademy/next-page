package kr.eddi.demo.notice.cotroller;

import kr.eddi.demo.notice.entity.Notice;
import kr.eddi.demo.notice.request.NoticeListRequest;
import kr.eddi.demo.notice.request.WriteNoticeRequest;
import kr.eddi.demo.notice.service.NoticeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/notice")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class NoticeController {

    @Autowired
    NoticeService noticeService;

    @PostMapping("/write")
    public Boolean writeNotice(@RequestBody WriteNoticeRequest writeNoticeRequest) {
        log.info("writeNotice(): " + writeNoticeRequest);
        return noticeService.writeNotice(writeNoticeRequest);
    }

    @DeleteMapping("/delete/{noticeNo}")
    public Boolean deleteNotice(@PathVariable("noticeNo") Long noticeNo) {
        log.info("deleteNotice(): " + noticeNo);
        return noticeService.deleteNotice(noticeNo);
    }

    @PostMapping("/get-list")
    public Page<Notice> getNoticeList(@RequestBody NoticeListRequest noticeListRequest) {
        log.info("getNoticeList(): " + noticeListRequest);

        PageRequest pageRequest =
                PageRequest.of(noticeListRequest.getPage(), noticeListRequest.getSize());

        return noticeService.getNoticeListFindByNovelInfoId(noticeListRequest.getNovelInfoId(), pageRequest);
    }
}
