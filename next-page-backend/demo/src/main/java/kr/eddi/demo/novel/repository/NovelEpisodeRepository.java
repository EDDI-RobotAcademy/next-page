package kr.eddi.demo.novel.repository;

import kr.eddi.demo.novel.entity.NovelEpisode;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface NovelEpisodeRepository extends JpaRepository<NovelEpisode, Long> {

    Page<NovelEpisode> findByInformation_Id(Long informationId, PageRequest request);

    Optional<NovelEpisode> findEpisodeByEpisodeNumber(Long episodeNumber);
}
