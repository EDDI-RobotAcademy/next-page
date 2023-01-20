package kr.eddi.demo.novel.repository;

import kr.eddi.demo.novel.entity.NovelInformation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface NovelInformationRepository extends JpaRepository<NovelInformation, Long> {

    Page<NovelInformation> findByMember_Id(Long memberId, PageRequest pageRequest);

    @Query("select n from NovelInformation n join fetch n.category c where c.categoryName = :categoryName")
    List<NovelInformation> findNovelByCategoryName(String categoryName);
}