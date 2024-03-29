package kr.eddi.demo.novel.controller;


import kr.eddi.demo.comment.request.CommentModifyRequest;
import kr.eddi.demo.novel.request.EpisodeModifyRequest;
import kr.eddi.demo.novel.request.NovelCategoryRequest;
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

    @PostMapping("/{memberNickname}/information-list")
    public Page<NovelInformation> getUploaderNovelInfoList(@PathVariable("memberNickname") String memberNickname, @RequestBody PageForm form){
        log.info("getUploaderNovelInfoList()");
        PageRequest request = PageRequest.of(form.getPage(), form.getSize());
        return novelService.getUploaderNovelInfoList(memberNickname, request);
    }

   @PostMapping("/novel-list/category")
    public List<NovelInformation> getNovelListByCategory(@RequestBody NovelCategoryRequest request){
        log.info("getNovelListByCategory()");
        log.info("요청한 카테고리명: " + request.getCategoryName());

        return novelService.getNovelListByCategory(request.getCategoryName());

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

    @GetMapping("/novel-list/short/{size}")
    public List<NovelInformation> getShortNovelList(@PathVariable("size") int size){
        log.info("getShortNovelList()");

        return novelService.getShortNovelList(size);

    }

    @GetMapping("/new-novel-list/short/{size}")
    public List<NovelInformation> getShortNewNovelList(@PathVariable("size") int size){
        log.info("getShortNewNovelList()");

        return novelService.getShortNewNovelList(size);

    }

    @DeleteMapping("/delete-episode/{episodeId}")
    public void episodeDelete (@PathVariable("episodeId") Long episodeId) {
        log.info("episodeDelete()" + episodeId);

        novelService.deleteNovelEpisode(episodeId);
    }

    @PutMapping("/modify-episode/{episodeId}")
    public void episodeModify (@PathVariable("episodeId") Long episodeId, @RequestBody EpisodeModifyRequest request) {
        log.info("episodeModify()");

        novelService.episodeModify(episodeId, request);
    }
}
