package kr.eddi.demo.novel.service;
import kr.eddi.demo.novel.entity.NovelEpisode;
import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.novel.request.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface NovelService {

    Boolean informationRegister(MultipartFile image, NovelInformationRegisterRequest request);

    Boolean informationModifyWithOutImg(Long novelInfoId, NovelInformationModifyRequest request);

    Boolean informationModifyWithImg(Long novelInfoId, MultipartFile image, NovelInformationModifyRequest request);

    void createCategory(Long id, String name);

    Boolean episodeRegister(NovelEpisodeRegisterRequest request);

    Page<NovelInformation> getUploaderNovelInfoList(String memberNickName, PageRequest request);

    List<NovelInformation> getNovelList();

    Map<String, Object> getNovelInfoDetail(Long novelInfoId);

    Page<NovelEpisode> getNovelEpisodeListByInfoId(Long novelInfoId, PageRequest request);


    List<NovelInformation> getNovelListByCategory(String categoryName);


    NovelEpisode getNovelEpisodeDetail(Long episodeId);

    public Boolean deleteNovelEpisode(Long episodeId);

    NovelEpisode getNovelEpisodeByEpisodeNumber(Long episodeNumber);

    void viewCountUp(Long novelId);

    List<NovelInformation> getShortNovelList(int size);

    List<NovelInformation> getShortNewNovelList(int size);

    Boolean episodeModify(Long episodeId, EpisodeModifyRequest episodeModifyRequest);
}
