package kr.eddi.demo.novel;


import kr.eddi.demo.member.entity.member.NextPageMember;
import kr.eddi.demo.member.entity.repository.member.MemberRepository;
import kr.eddi.demo.novel.entity.NovelCategory;
import kr.eddi.demo.novel.entity.NovelCoverImage;
import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.novel.repository.CoverImageRepository;
import kr.eddi.demo.novel.repository.NovelCategoryRepository;
import kr.eddi.demo.novel.repository.NovelInformationRepository;
import kr.eddi.demo.novel.request.NovelInformationRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

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

    @Override
    @Transactional
    public Boolean informationRegister(List<MultipartFile> imgList, NovelInformationRequest request) {

        // request에서 받은 멤버 아이디로 회원 찾고 권한 체크 (이후 권한 부여 시스템 작성 후에 로직 추가 할예정)
        Optional<NextPageMember> maybeMember = memberRepository.findById(request.getMember_id());
        if(maybeMember.isEmpty()) {
            return false;
        }
        NextPageMember member = maybeMember.get();


        // 카테고리 찾기
        Optional<NovelCategory> maybeCategory = categoryRepository.findByCategoryNameContainingIgnoreCase(request.getCategory());
        if(maybeCategory.isEmpty()) {
            return false;
        }
        NovelCategory category = maybeCategory.get();


        // 소설정보 entity 생성
        NovelInformation information = request.toEntity();


        // 커버이미지 entity 생성
        try {
            for (MultipartFile multipartFile: imgList) {
                log.info("requestUploadFilesWithText() - Make file: " + multipartFile.getOriginalFilename());

                UUID fileRandomName = UUID.randomUUID();

                String fileReName = fileRandomName + multipartFile.getOriginalFilename();

                // 저장 경로 지정 + 파일네임
                FileOutputStream writer = new FileOutputStream("../../next-page-vue/frontend/src/assets/coverImages/" + fileReName);
                FileOutputStream writer2 = new FileOutputStream("../../next-page-flutter/app/assets/images/thumbnail/" + fileReName);
                log.info("디렉토리에 파일 배치 성공!");

                // 파일 저장(저장할 때는 byte 형식으로 저장해야 하므로 파라미터로 받은 multipartFile 파일들의 getBytes() 메소드를 적용하여 저장
                writer.write(multipartFile.getBytes());
                writer2.write(multipartFile.getBytes());

                // 커버이미지 entity에 값 세팅
                NovelCoverImage coverImage = new NovelCoverImage(
                        multipartFile.getOriginalFilename(),
                        fileReName,
                        information
                );


                // 정보 entity 측에 커버이미지 entity 저장
                coverImage.updateToInformation();
                coverImageRepository.save(coverImage);
                writer.close();
                writer2.close();

            }
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
     * 카테고리를 생성합니다
     * @param id 카테고리 번호
     * @param name 카테고리 이름
     */

    @Override
    public void createCategory(Long id, String name) {
        NovelCategory category = new NovelCategory(id, name);
        categoryRepository.save(category);
    }

    @Override
    public List<NovelInformation> getManagingNovelInfoList(Long memberId) {

        return null;
    }
}
