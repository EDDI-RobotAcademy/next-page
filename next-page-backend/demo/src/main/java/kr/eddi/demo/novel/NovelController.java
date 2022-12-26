package kr.eddi.demo.novel;


import kr.eddi.demo.novel.entity.NovelEpisode;
import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.novel.form.NovelEpisodeRegisterForm;
import kr.eddi.demo.novel.form.NovelInformationRegisterForm;
import kr.eddi.demo.novel.form.PageForm;
import kr.eddi.demo.novel.repository.NovelEpisodeRepository;
import kr.eddi.demo.novel.repository.NovelInformationRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

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
    public Boolean informationRegister(@RequestPart(value = "fileList") List<MultipartFile> imgList,
                                       @RequestPart(value = "info") NovelInformationRegisterForm form) {

        log.info("information form: " + form);
        return novelService.informationRegister(imgList, form.toRequest());
    }


    @PostMapping("/episode-register")
    public Boolean episodeRegister(@RequestBody NovelEpisodeRegisterForm form) {
        return novelService.episodeRegister(form.toRequest());
    }

    @PostMapping("/{member_id}/information-list")
    public Page<NovelInformation> getUploaderNovelInfoList(@PathVariable("member_id") Long member_id, @RequestBody PageForm form){
        PageRequest request = PageRequest.of(form.getPage(), form.getSize());
        return novelService.getUploaderNovelInfoList(member_id, request);
    }

    @GetMapping("/information-detail/{novel_info_id}")
    public NovelInformation getNovelInfoDetail (@PathVariable("novel_info_id") Long novel_info_id) {
        return novelService.getNovelInfoDetail(novel_info_id);
    }

    @PostMapping("/episode-list/{novel_info_id}")
    public Page<NovelEpisode> getNovelEpisodeList(@PathVariable("novel_info_id") Long novel_info_id, @RequestBody PageForm form) {
        PageRequest request = PageRequest.of(form.getPage(), form.getSize());
        return novelService.getNovelEpisodeListByInfoId(novel_info_id, request);
    }
}
