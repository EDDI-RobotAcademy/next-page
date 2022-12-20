package kr.eddi.demo.novel.repository;

import kr.eddi.demo.novel.entity.NovelInformation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NovelInformationRepository extends JpaRepository<NovelInformation, Long> {

}
