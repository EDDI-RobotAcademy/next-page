package kr.eddi.demo.novel;


import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.novel.form.NovelEpisodeRegisterForm;
import kr.eddi.demo.novel.form.NovelInformationRegisterForm;
import kr.eddi.demo.novel.form.PageForm;
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
}
