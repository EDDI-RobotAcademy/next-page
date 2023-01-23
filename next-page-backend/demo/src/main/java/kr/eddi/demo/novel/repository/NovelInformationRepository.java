package kr.eddi.demo.novel.repository;

import kr.eddi.demo.novel.entity.NovelInformation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;


public interface NovelInformationRepository extends JpaRepository<NovelInformation, Long> {

    Page<NovelInformation> findByMemberNickName(String nickName, PageRequest pageRequest);

    @Query("select n from NovelInformation n join fetch n.member m where m.nickName = :nickName order by n.viewCount desc")
    Slice<NovelInformation> findNovelInformation(Pageable pageable, String nickName);
    @Query("select n from NovelInformation n join fetch n.member m where m.nickName = :nickName order by n.id desc")
    Slice<NovelInformation> findNovelInformationById(Pageable pageable, String nickName);

}