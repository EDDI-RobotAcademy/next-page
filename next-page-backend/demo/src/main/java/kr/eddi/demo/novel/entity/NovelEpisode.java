package kr.eddi.demo.novel.entity;


import com.fasterxml.jackson.annotation.JsonIgnore;
import kr.eddi.demo.comment.entity.Comment;
import kr.eddi.demo.episode_payment.entity.EpisodePayment;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@EntityListeners(AuditingEntityListener.class)
@NoArgsConstructor
public class NovelEpisode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private Long episodeNumber;

    @Column
    private String episodeTitle; // 에피소드별 제목

    @Column
    private String text; // 에피소드 내용

    @Column
    private Boolean needToBuy; // 유료결제여부

    @CreatedDate
    private LocalDate uploadedDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @JoinColumn(name = "information_id")
    private NovelInformation information;


    @JsonIgnore
    @OneToMany(mappedBy = "novelEpisode", fetch = FetchType.LAZY)
    private List<Comment> commentList = new ArrayList<>();

    /*@JsonIgnore
    @OneToMany(mappedBy = "novelEpisode", fetch = FetchType.LAZY)
    private List<EpisodePayment> episodePayments = new ArrayList<>();*/

    public NovelEpisode(Long episodeNumber, String episodeTitle, String text, Boolean needToBuy, NovelInformation information) {
        this.episodeNumber = episodeNumber;
        this.episodeTitle = episodeTitle;
        this.text = text;
        this.needToBuy = needToBuy;
        this.information = information;
    }

    /**
     * 맵핑된 소설 정보 엔티티에 해당 에피소드를 업데이트 합니다.
     */
    public void updateToInformation() {
        this.information.updateEpisode(this);
    }

    public void updateComment(Comment comment) {
        commentList.add(comment);
    }

   /* public void updateEpisodePayments(EpisodePayment episodePayment) {
        this.episodePayments.add(episodePayment);
    }*/

}