package kr.eddi.demo.notice.repository;

import kr.eddi.demo.notice.entity.Notice;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NoticeRepository extends JpaRepository <Notice, Long> {
    Page<Notice> getNoticeListFindByNovelInfoId(Long novelInfoId, PageRequest request, Sort sort);
}
