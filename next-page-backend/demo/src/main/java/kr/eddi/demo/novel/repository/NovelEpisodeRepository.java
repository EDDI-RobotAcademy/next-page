package kr.eddi.demo.novel.repository;

import kr.eddi.demo.novel.entity.NovelEpisode;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NovelEpisodeRepository extends JpaRepository<NovelEpisode, Long> {
}
