package kr.eddi.demo.novel.entity;


import com.fasterxml.jackson.annotation.JsonIgnore;
import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.novel.request.NovelInformationModifyRequest;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Getter
public class NovelInformation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private String title; // 제목

    @Lob
    private String introduction; // 소개문구

    @Column
    private String publisher; // 출판사

    @Column
    private String author; // 작가

    @Column
    private Long purchasePoint; // 유료 구매시의 포인트

    @Column(nullable = false)
    private Long viewCount; //조회수

    @Column(nullable = false)
    private Long commentCount; //댓글수

    @Column(nullable = false)
    private int totalStarRating; //별점 총합

    @Column(nullable = true)
    private int ratingCount; //별점 주기 횟수

    @Column
    private Boolean openToPublic; // 공개여부

    @CreatedDate
    private LocalDate createdDate; // 생성시간


    @JsonIgnore
    @OneToMany(mappedBy = "information", fetch = FetchType.LAZY)
    private List<NovelEpisode> episodeList = new ArrayList<>();

    @OneToOne(mappedBy = "information", fetch = FetchType.EAGER)
    private NovelCoverImage coverImage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @JoinColumn(name = "member_id")
    private NextPageMember member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @JoinColumn(name = "category_id")
    private NovelCategory category;

    public NovelInformation(String title, String introduction, String publisher, String author, Boolean openToPublic, Long purchasePoint) {
        this.title = title;
        this.introduction = introduction;
        this.publisher = publisher;
        this.author = author;
        this.openToPublic = openToPublic;
        this.purchasePoint = purchasePoint;
        this.viewCount = 0L;
        this.commentCount = 0L;
        this.ratingCount = 0;
    }

    public void modify(NovelInformationModifyRequest request, NovelCategory category) {
        this.title = request.getTitle();
        this.introduction = request.getIntroduction();
        this.publisher = request.getPublisher();
        this.author = request.getAuthor();
        this.openToPublic = request.getOpenToPublic();
        this.purchasePoint = request.getPurchasePoint();
        this.category = category;
    }

    /**
     * 해당 소설 정보를 등록한 회원 정보에 해당 엔티티를 업데이트 합니다.
     * @param member
     */
    public void updateToMember(NextPageMember member) {
        this.member = member;
        this.member.updateNovelInformationList(this);
    }

    /**
     * 맵핑된 카테고리에 엔티티를 업데이트 합니다.
     * @param category
     */

    public void updateToCategory(NovelCategory category) {
        this.category = category;
        this.category.updateNovelInformation(this);
    }

    /**
     * 표지 이미지 이름 정보 엔티티를 매핑합니다.
     * @param coverImage
     */
    public void updateCoverImage(NovelCoverImage coverImage) {
        this.coverImage = coverImage;
    }

    /**
     * 에피소드 리스트에 에피소드 엔티티를 추가합니다.
     * @param episode
     */
    public void updateEpisode(NovelEpisode episode) {
        this.episodeList.add(episode);
    }

    // 댓글 작성 시 전체 댓글 수에서 +1
    public void addCommentCount() {
        this.commentCount += 1;
    }
    // 댓글 삭제 시 전체 댓글 수에서 -1
    public void minusCommentCount() { this.commentCount -=1; }

    // 에피소드 열람시 전체 조회수 +1
    public void updateViewCount(){
        this.viewCount += 1;
    }

    // 별점 주기 시 별점 주기 횟수 +1
    public void addRatingCount(){
        this.ratingCount +=1;
    }

    //별점 주기 시 별점 총합 + 별점 만큼
    public void addTotalStarRating(int starRating){
        this.totalStarRating +=starRating;
    }

    //별점 수정 시 별점 총합 - 기존 별점 만큼
    public void minusTotalStarRating(int starRating){
        this.totalStarRating -=starRating;
    }

}
