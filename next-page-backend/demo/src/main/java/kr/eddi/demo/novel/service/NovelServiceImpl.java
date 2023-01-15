package kr.eddi.demo.novel.service;


import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.member.repository.MemberRepository;
import kr.eddi.demo.novel.entity.NovelCategory;
import kr.eddi.demo.novel.entity.NovelCoverImage;
import kr.eddi.demo.novel.entity.NovelEpisode;
import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.novel.repository.CoverImageRepository;
import kr.eddi.demo.novel.repository.NovelCategoryRepository;
import kr.eddi.demo.novel.repository.NovelEpisodeRepository;
import kr.eddi.demo.novel.repository.NovelInformationRepository;
import kr.eddi.demo.novel.request.NovelEpisodeRegisterRequest;
import kr.eddi.demo.novel.request.NovelInformationModifyRequest;
import kr.eddi.demo.novel.request.NovelInformationRegisterRequest;
import kr.eddi.demo.novel.service.NovelService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;

@Service
@Slf4j
public class NovelServiceImpl implements NovelService {


    @Autowired
    MemberRepository memberRepository;

    @Autowired
    CoverImageRepository coverImageRepository;

    @Autowired
    NovelInformationRepository informationRepository;

    @Autowired
    NovelCategoryRepository categoryRepository;

    @Autowired
    NovelEpisodeRepository episodeRepository;

    @Override
    @Transactional
    public Boolean informationRegister(MultipartFile image, NovelInformationRegisterRequest request) {

        // request에서 받은 멤버 아이디로 회원 찾고 권한 체크 (이후 권한 부여 시스템 작성 후에 로직 추가 할예정)
        Optional<NextPageMember> maybeMember = memberRepository.findById(request.getMember_id());
        if(maybeMember.isEmpty()) {
            return false;
        }
        NextPageMember member = maybeMember.get();

        log.info("category를 왜 못찾냐 : " +request.getCategory());

        // 카테고리 찾기
        Optional<NovelCategory> maybeCategory = categoryRepository.findByCategoryNameContainingIgnoreCase(request.getCategory());
        if(maybeCategory.isEmpty()) {
            return false;
        }
        NovelCategory category = maybeCategory.get();

        log.info("쿼리 검색 결과 "+ category.getCategoryName());


        // 소설정보 entity 생성
        NovelInformation information = request.toEntity();


        // 커버이미지 entity 생성
        try {
                log.info("requestUploadFilesWithText() - Make file: " + image.getOriginalFilename());

                UUID fileRandomName = UUID.randomUUID();

                String fileReName = fileRandomName +image.getOriginalFilename();

                // 저장 경로 지정 + 파일네임
                FileOutputStream writer2 = new FileOutputStream("../../next-page-flutter/app/assets/images/thumbnail/" + fileReName);
                log.info("디렉토리에 파일 배치 성공!");

                // 파일 저장(저장할 때는 byte 형식으로 저장해야 하므로 파라미터로 받은 multipartFile 파일들의 getBytes() 메소드를 적용하여 저장
                writer2.write(image.getBytes());

                // 커버이미지 entity에 값 세팅
                NovelCoverImage coverImage = new NovelCoverImage(
                        image.getOriginalFilename(),
                        fileReName,
                        information
                );


                // 정보 entity 측에 커버이미지 entity 저장
                coverImage.updateToInformation();
                coverImageRepository.save(coverImage);
                writer2.close();

        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        // 소설 정보 entity에 등록한 회원 정보, 카테고리 업데이트 후 저장
        information.updateToCategory(category);
        information.updateToMember(member);

        informationRepository.save(information);

        return true;
    }

    /**
     * 이미지 없이 소설 정보를 수정할 때에 사용되는 메소드입니다
     * @param novelInfoId
     * @param request
     * @return
     */
    @Override
    public Boolean informationModifyWithOutImg(Long novelInfoId, NovelInformationModifyRequest request) {
        Optional<NovelInformation> maybeNovelInfo = informationRepository.findById(novelInfoId);
        if(maybeNovelInfo.isEmpty()) {
            return false;
        }
        NovelInformation novelInfo = maybeNovelInfo.get();
        novelInfo.modify(request);
        informationRepository.save(novelInfo);
        return true;
    }


    @Override
    @Transactional
    public Boolean informationModifyWithImg(Long novelInfoId, MultipartFile image, NovelInformationModifyRequest request) {

        Optional<NovelInformation> maybeNovelInfo = informationRepository.findById(novelInfoId);
        if(maybeNovelInfo.isEmpty()) {
            return false;
        }
        NovelInformation novelInfo = maybeNovelInfo.get();
        novelInfo.modify(request);

        Optional<NovelCoverImage> maybeCoverImg = coverImageRepository.findByInformation_Id(novelInfoId);
        if(maybeCoverImg.isEmpty()) {
            return false;
        }
        NovelCoverImage coverImage = maybeCoverImg.get();

        // 커버이미지 entity 수정
        try {
                log.info("requestUploadFilesWithText() - Make file: " + image.getOriginalFilename());

                UUID fileRandomName = UUID.randomUUID();

                String fileReName = fileRandomName + image.getOriginalFilename();

                // 저장 경로 지정 + 파일네임
                FileOutputStream writer2 = new FileOutputStream("../../next-page-flutter/app/assets/images/thumbnail/" + fileReName);
                log.info("디렉토리에 파일 배치 성공!");

                // 파일 저장(저장할 때는 byte 형식으로 저장해야 하므로 파라미터로 받은 multipartFile 파일들의 getBytes() 메소드를 적용하여 저장
                writer2.write(image.getBytes());

                // 커버이미지 entity에 이미지 정보값 수정
               coverImage.modify(
                       image.getOriginalFilename(),
                        fileReName
               );


             /*   // 정보 entity 측에 새롭게 바꾼 커버이미지 entity 업데이트
                coverImage.updateToInformation();*/
                coverImageRepository.save(coverImage);
                writer2.close();

        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }


        // 수정한 소설 정보 entity 저장
        informationRepository.save(novelInfo);

        return true;
    }




    /**
     * 카테고리를 생성합니다
     * @param id 카테고리 번호
     * @param name 카테고리 이름
     */

    @Override
    public void createCategory(Long id, String name) {
        NovelCategory category = new NovelCategory(id, name);
        categoryRepository.save(category);
    }

    /**
     * 에피소드를 저장합니다
     * @param request
     * @return
     */


    @Override
    @Transactional
    public Boolean episodeRegister(NovelEpisodeRegisterRequest request) {
        Optional<NovelInformation> maybeInformation = informationRepository.findById(request.getInformation_id());
        if(maybeInformation.isEmpty()) {
            return false;
        }
        NovelInformation information = maybeInformation.get();
        NovelEpisode episode = request.toEntity(information);
        episode.updateToInformation();
        episodeRepository.save(episode);
        return true;
    }

    /**
     * 특정 관리자 회원이 등록한 소설 정보 리스트를 가져옵니다.
     * @param member_id
     * @param request
     * @return
     */

    @Override
    public Page<NovelInformation> getUploaderNovelInfoList(Long member_id, PageRequest request) {
        return informationRepository.findByMember_Id(member_id, request);
    }

    /**
     * 등록된 모든 소설 리스트를 가져옵니다.
     * @return
     */
    @Override
    public List<NovelInformation> getNovelList(){
        List<NovelInformation> tmpList = informationRepository .findAll(Sort.by(Sort.Direction.DESC, "id"));

        log.info("모든 소설 리스트: "+String.valueOf(tmpList));

        return tmpList;
    }


    /**
     * 소설 정보 상세 사항을 가져옵니다.
     * @param novelInfoId
     * @return
     */

    @Transactional
    @Override
    public Map<String, Object> getNovelInfoDetail(Long novelInfoId) {
        Optional<NovelInformation> maybeInfo = informationRepository.findById(novelInfoId);
        if(maybeInfo.isEmpty()) {
            return null;
        } else {
            NovelInformation novelInfo = maybeInfo.get();

           Map<String, Object> tmpNovelInfo = new HashMap<>();
            tmpNovelInfo.put("category", novelInfo.getCategory().getCategoryName());
            tmpNovelInfo.put("id", novelInfo.getId());
            tmpNovelInfo.put("title", novelInfo.getTitle());
            tmpNovelInfo.put("introduction", novelInfo.getIntroduction());
            tmpNovelInfo.put("publisher", novelInfo.getPublisher());
            tmpNovelInfo.put("author", novelInfo.getAuthor());
            tmpNovelInfo.put("purchasePoint", novelInfo.getPurchasePoint());
            tmpNovelInfo.put("openToPublic", novelInfo.getOpenToPublic());
            tmpNovelInfo.put("createdDate", novelInfo.getCreatedDate());
            tmpNovelInfo.put("thumbnail", novelInfo.getCoverImage().getReName());
            tmpNovelInfo.put("viewCount", novelInfo.getViewCount());
            tmpNovelInfo.put("starRating", novelInfo.getStarRating());
            tmpNovelInfo.put("commentCount", novelInfo.getCommentCount());



            log.info(tmpNovelInfo.toString());

            return tmpNovelInfo;
        }
    }


    /**
     * 소설 정보에 해당하는 에피소드 리스트를 가져옵니다.
     * @param novelInfoId
     * @param request
     * @return
     */
    @Override
    public Page<NovelEpisode> getNovelEpisodeListByInfoId(Long novelInfoId, PageRequest request) {
        return episodeRepository.findByInformation_Id(novelInfoId, request);
    }

    /**
     * 에피소드 상세사항을 가져옵니다.
     * @param episodeId
     * @return
     */

    @Override
    public NovelEpisode getNovelEpisodeDetail(Long episodeId) {

        Optional<NovelEpisode> maybeEpisode =  episodeRepository.findById(1L);
        if(maybeEpisode.isEmpty()) {
            return null;
        }

        NovelEpisode episode = maybeEpisode.get();
        return episode;
    }

    /**
     * 등록된 에피소드를 삭제합니다.
     * @param episodeId
     * @return
     */
    @Override
    public Boolean deleteNovelEpisode(Long episodeId){

        Optional<NovelEpisode> maybeEpisode = episodeRepository.findById(episodeId);

        if (maybeEpisode.isPresent()) {

            NovelEpisode episode = maybeEpisode.get();

            episodeRepository.delete(episode);
            log.info("에피소드 삭제 성공!");
            return true;

        }
        log.info("해당 에피소드가 존재하지 않습니다.");
        return false;
    }

    @Override
    public NovelEpisode getNovelEpisodeByEpisodeNumber(Long episodeNumber){

        Optional<NovelEpisode> maybeEpisode = episodeRepository.findEpisodeByEpisodeNumber(episodeNumber);

        if(maybeEpisode.isPresent()){

            NovelEpisode episode = maybeEpisode.get();

            return episode;
        }
        return null;
    }

    @Override
    public  void viewCountUp(Long novelId){
        Optional<NovelInformation> maybeInformation = informationRepository.findById(novelId);

        NovelInformation novel = maybeInformation.get();

        novel.updateViewCount();

        informationRepository.save(novel);

    }

}
