package kr.eddi.demo.novel;

import kr.eddi.demo.novel.request.NovelEpisodeRegisterRequest;
import kr.eddi.demo.novel.request.NovelInformationRegisterRequest;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface NovelService {

    Boolean informationRegister(List<MultipartFile> imageFile, NovelInformationRegisterRequest request);

    void createCategory(Long id, String name);

    Boolean episodeRegister(NovelEpisodeRegisterRequest request);
}
