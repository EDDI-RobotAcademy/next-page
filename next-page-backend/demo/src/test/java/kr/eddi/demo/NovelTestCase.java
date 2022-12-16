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
        service.createCategory(4L, "현대");
    }

    @Test
    void getInformationListByMemberId() {
        List<NovelInformation> informationList = informationRepository.findByMember_Id(1L);
        System.out.println(informationList);
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
        NovelEpisodeRegisterRequest request = new NovelEpisodeRegisterRequest(1L, 3L, "안녕하세요", "234ㅁㄴㅇㄻㄴㅇsㄴㅇㄹ", false);
        Boolean isOk = service.episodeRegister(request);
        System.out.println("isOk?: " + isOk);
    }
}
