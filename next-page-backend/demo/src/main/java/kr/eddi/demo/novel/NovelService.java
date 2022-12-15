package kr.eddi.demo.novel;

import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.novel.request.NovelEpisodeRegisterRequest;
import kr.eddi.demo.novel.request.NovelInformationRequest;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface NovelService {

    Boolean informationRegister(List<MultipartFile> imageFile, NovelInformationRequest request);

    void createCategory(Long id, String name);

    Boolean episodeRegister(NovelEpisodeRegisterRequest request);
}
