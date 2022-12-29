package kr.eddi.demo.novel.repository;

import kr.eddi.demo.novel.entity.NovelCoverImage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CoverImageRepository extends JpaRepository<NovelCoverImage, Long> {

    Optional<NovelCoverImage> findByInformation_Id(Long id);
}
