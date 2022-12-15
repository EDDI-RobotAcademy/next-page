package kr.eddi.demo.novel.repository;

import kr.eddi.demo.novel.entity.NovelCoverImage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CoverImageRepository extends JpaRepository<NovelCoverImage, Long> {
}
