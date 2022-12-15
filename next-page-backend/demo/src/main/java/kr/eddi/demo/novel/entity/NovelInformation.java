package kr.eddi.demo.novel.entity;


import kr.eddi.demo.member.entity.member.NextPageMember;
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

    @Column
    private Boolean openToPublic; // 공개여부

    @CreatedDate
    private LocalDate createdDate; // 생성시간

    @OneToMany(mappedBy = "information", fetch = FetchType.LAZY)
    private List<NovelEpisode> episodeList = new ArrayList<>();

    @OneToOne(mappedBy = "information", fetch = FetchType.EAGER)
    private NovelCoverImage coverImage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private NextPageMember member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private NovelCategory category;

    public NovelInformation(String title, String introduction, String publisher, String author, Boolean openToPublic, Long purchasePoint) {
        this.title = title;
        this.introduction = introduction;
        this.publisher = publisher;
        this.author = author;
        this.openToPublic = openToPublic;
        this.purchasePoint = purchasePoint;
    }

    public void updateToMember(NextPageMember member) {
        this.member = member;
        this.member.updateNovelInformationList(this);
    }

    public void updateToCategory(NovelCategory category) {
        this.category = category;
        this.category.updateNovelInformation(this);
    }

    public void updateCoverImage(NovelCoverImage coverImage) {
        this.coverImage = coverImage;
    }

    public void updateEpisode(NovelEpisode episode) {
        this.episodeList.add(episode);
    }
}
