package kr.eddi.demo.novel.service;

import kr.eddi.demo.novel.entity.NovelEpisode;
import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.novel.request.NovelEpisodeRegisterRequest;
import kr.eddi.demo.novel.request.NovelInformationModifyRequest;
import kr.eddi.demo.novel.request.NovelInformationRegisterRequest;
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

    Page<NovelInformation> getUploaderNovelInfoList(Long member_id, PageRequest request);

    List<NovelInformation> getNovelList();

    Map<String, Object> getNovelInfoDetail(Long novelInfoId);

    Page<NovelEpisode> getNovelEpisodeListByInfoId(Long novelInfoId, PageRequest request);

    NovelEpisode getNovelEpisodeDetail(Long episodeId);

    public Boolean deleteNovelEpisode(Long episodeId);

    NovelEpisode getNovelEpisodeByEpisodeNumber(Long episodeNumber);
}
