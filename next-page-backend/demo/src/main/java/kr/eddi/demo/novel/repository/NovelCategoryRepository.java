package kr.eddi.demo.novel.repository;

import kr.eddi.demo.novel.entity.NovelCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface NovelCategoryRepository extends JpaRepository<NovelCategory, Long> {

    Optional<NovelCategory> findByCategoryNameContainingIgnoreCase(String categoryName);

}
