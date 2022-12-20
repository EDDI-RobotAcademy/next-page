package kr.eddi.demo.novel.repository;

import kr.eddi.demo.novel.entity.NovelInformation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;


public interface NovelInformationRepository extends JpaRepository<NovelInformation, Long> {

    Page<NovelInformation> findByMember_Id(Long memberId, PageRequest pageRequest);
}