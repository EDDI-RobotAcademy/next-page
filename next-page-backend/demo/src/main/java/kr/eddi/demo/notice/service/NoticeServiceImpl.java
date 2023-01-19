package kr.eddi.demo.notice.service;

import kr.eddi.demo.notice.entity.Notice;
import kr.eddi.demo.notice.repository.NoticeRepository;
import kr.eddi.demo.notice.request.WriteNoticeRequest;
import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.novel.repository.NovelInformationRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Slf4j
@Service
public class NoticeServiceImpl implements NoticeService {
    @Autowired
    NoticeRepository noticeRepository;

    @Autowired
    NovelInformationRepository novelInfoRepository;

    public Page<Notice> getNoticeListFindByNovelInfoId(Long novelInfoId, PageRequest pageRequest) {
        // NovelInfoId 값이 0이면 일반공지
        if (novelInfoId == 0) {
            log.info("일반 공지사항 조회");
            return noticeRepository.getNoticeListFindByNovelInfoId(novelInfoId, pageRequest, Sort.by(Sort.Direction.DESC, "noticeNo"));
        } else {
            Optional<NovelInformation> maybeNovelInfo = novelInfoRepository.findById(novelInfoId);

            if (maybeNovelInfo.isPresent()) {
                return noticeRepository.getNoticeListFindByNovelInfoId(novelInfoId, pageRequest, Sort.by(Sort.Direction.DESC, "noticeNo"));
            }
            throw new RuntimeException("해당 소설의 공지 정보 없음!");
        }
    }

    public Boolean writeNotice(WriteNoticeRequest writeNoticeRequest) {
        // NovelInfoId 값이 0이면 일반공지
        if (writeNoticeRequest.getNovelInfoId() == 0) {
            Notice notice = writeNoticeRequest.toEntity();
            noticeRepository.save(notice);
            return true;
        } else {
            Optional<NovelInformation> maybeNovelInfo =
                    novelInfoRepository.findById(writeNoticeRequest.getNovelInfoId());

            if (maybeNovelInfo.isPresent()) {
                Notice notice = writeNoticeRequest.toEntity();
                noticeRepository.save(notice);
                return true;
            }
        }
        throw new RuntimeException("해당 id 소설 정보 없음!");
    }

    public Boolean deleteNotice(Long noticeNo) {
        Optional<Notice> maybeNotice = noticeRepository.findById(noticeNo);

        if (maybeNotice.isPresent()) {
            noticeRepository.deleteById(noticeNo);
            return true;
        }
        throw new RuntimeException("공지 없음!");
    }
}
