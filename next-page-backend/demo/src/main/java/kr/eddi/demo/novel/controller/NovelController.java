package kr.eddi.demo.novel.controller;


import kr.eddi.demo.novel.service.NovelServiceImpl;
import kr.eddi.demo.novel.entity.NovelEpisode;
import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.novel.form.NovelEpisodeRegisterForm;
import kr.eddi.demo.novel.form.NovelInformationModifyForm;
import kr.eddi.demo.novel.form.NovelInformationRegisterForm;
import kr.eddi.demo.novel.form.PageForm;
import kr.eddi.demo.novel.repository.NovelEpisodeRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/novel")
@Slf4j
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class NovelController {


    @Autowired
    NovelServiceImpl novelService;

    @Autowired
    NovelEpisodeRepository episodeRepository;


    @PostMapping(value = "/information-register",  consumes = { MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_JSON_VALUE })
    public Boolean informationRegister(@RequestPart(value = "file") MultipartFile image,
                                       @RequestPart(value = "info") NovelInformationRegisterForm form) {

        log.info("image: " + image);
        log.info("information form: " + form);
        return novelService.informationRegister(image, form.toRequest());
    }

    @PostMapping("/information-modify-text/{novel_info_id}")
    public Boolean informationModifyWithOutFile(@PathVariable("novel_info_id") Long novel_info_id, @RequestBody NovelInformationModifyForm form) {
        log.info("information modify form: " + form);
        return novelService.informationModifyWithOutImg(novel_info_id, form.toRequest());
    }

    @PostMapping(value = "/information-modify-with-file/{novel_info_id}", consumes = { MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_JSON_VALUE })
    public Boolean informationModifyWithFile(@PathVariable("novel_info_id") Long novel_info_id,
                                             @RequestPart(value = "file") MultipartFile image,
                                             @RequestPart(value = "info") NovelInformationModifyForm form) {

        log.info("information modify form: " + form);

        return novelService.informationModifyWithImg(novel_info_id, image, form.toRequest());
    }


    @PostMapping("/episode-register")
    public Boolean episodeRegister(@RequestBody NovelEpisodeRegisterForm form) {

        log.info("episodeRegister()");

        return novelService.episodeRegister(form.toRequest());
    }

    @PostMapping("/{member_id}/information-list")
    public Page<NovelInformation> getUploaderNovelInfoList(@PathVariable("member_id") Long member_id, @RequestBody PageForm form){
        log.info("getUploaderNovelInfoList()");
        PageRequest request = PageRequest.of(form.getPage(), form.getSize());
        return novelService.getUploaderNovelInfoList(member_id, request);
    }

    @GetMapping("/all-novel-list")
    public List<NovelInformation> getNovelList(){
        log.info("getNovelList()");

        return novelService.getNovelList();
    }

    @GetMapping("/information-detail/{novel_info_id}")
    public Map<String, Object> getNovelInfoDetail (@PathVariable("novel_info_id") Long novel_info_id) {
        log.info("getNovelInfoDetail()");

        return novelService.getNovelInfoDetail(novel_info_id);
    }

    @PostMapping("/episode-list/{novel_info_id}")
    public Page<NovelEpisode> getNovelEpisodeList(@PathVariable("novel_info_id") Long novel_info_id, @RequestBody PageForm form) {
        log.info("getNovelEpisodeList()");

        PageRequest request = PageRequest.of(form.getPage(), form.getSize());
        return novelService.getNovelEpisodeListByInfoId(novel_info_id, request);
    }

    @GetMapping("/episode/{episode_id}")
    public NovelEpisode getNovelEpisodeDetail(@PathVariable("episode_id") Long episode_id) {
        log.info("getNovelEpisodeDetail()");

        return novelService.getNovelEpisodeDetail(episode_id);
    }

    @GetMapping("/view-count-up/{novel_info_id}")
    public void viewCountUp(@PathVariable("novel_info_id") Long novel_info_id) {
        log.info("viewCountUp()");

        novelService.viewCountUp(novel_info_id);
    }
}
