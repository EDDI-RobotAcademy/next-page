package kr.eddi.demo;


import kr.eddi.demo.novel.NovelServiceImpl;
import kr.eddi.demo.novel.entity.NovelEpisode;
import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.novel.repository.NovelEpisodeRepository;
import kr.eddi.demo.novel.repository.NovelInformationRepository;
import kr.eddi.demo.novel.request.NovelEpisodeRegisterRequest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@SpringBootTest
public class NovelTestCase {


    @Autowired
    NovelServiceImpl service;

    @Autowired
    NovelInformationRepository informationRepository;

    @Autowired
    NovelEpisodeRepository episodeRepository;

    @Test
    void createCategory() {
        service.createCategory(1L, "판타지");
        service.createCategory(2L, "무협");
        service.createCategory(3L, "로맨스");
        service.createCategory(4L, "현대판타지");
        service.createCategory(5L, "BL");
    }


    @Test
    @Transactional
    void episodeRegister() {
        Optional<NovelInformation> maybeInformation = informationRepository.findById(1L);
        NovelInformation information = maybeInformation.get();
        NovelEpisode episode = new NovelEpisode(1L, "안녕하세요", "234ㅁㄴㅇㄻㄴㅇㄹ ㅁㄴㅇㄻㄴㅇㄻㄴㅇㄹ ㄴㅇㄹ", false, information);
        episode.updateToInformation();
        episodeRepository.save(episode);
    }

    @Test
    void episodeRegisterAtService() {
        NovelEpisodeRegisterRequest request = new NovelEpisodeRegisterRequest(1L, 1L, "안녕하세요", "234ㅁㄴㅇㄻㄴㅇsㄴㅇㄹ", false);
        Boolean isOk = service.episodeRegister(request);
        System.out.println("isOk?: " + isOk);
    }

    @Test
    void getMemberInformationList() {
        PageRequest request = PageRequest.of(0, 1);
        Page<NovelInformation> informationList = informationRepository.findByMember_Id(1L, request);
        System.out.println("informationList: " + informationList);
    }

    @Test
    void getNovelList(){
        List<NovelInformation> tmpList = informationRepository .findAll(Sort.by(Sort.Direction.DESC, "id"));

        System.out.println("모든 소설 리스트: "+ tmpList);

    }

    @Test
    void getNovelInfoDetailWithEpisodeList() {
        Optional<NovelInformation> maybeInfo = informationRepository.findById(1l);
        Boolean isOk;
        if(maybeInfo.isEmpty()) {
            isOk = false;
        } else {
            NovelInformation novelInfo = maybeInfo.get();
            System.out.println(novelInfo);
        }
    }
    @Test
    void getNovelEpisodeListByInfoIdTest() {
        PageRequest request = PageRequest.of(0,1);
        Page<NovelEpisode> episodePage = episodeRepository.findByInformation_Id(1l, request);
        System.out.println("result: " + episodePage);
    }

    @Test
    void getNovelEpisodeDetailTest() {
        NovelEpisode episode;

        Optional<NovelEpisode> maybeEpisode =  episodeRepository.findById(1L);
        if(maybeEpisode.isEmpty()) {
            episode = null;
        }

        episode = maybeEpisode.get();

        System.out.println("getEpisodeDetail: " + episode);

    }
}
