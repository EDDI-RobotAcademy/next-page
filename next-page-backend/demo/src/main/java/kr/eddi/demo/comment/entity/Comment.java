package kr.eddi.demo.comment.entity;


import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.novel.entity.NovelEpisode;
import kr.eddi.demo.qna.entity.QnA;
import lombok.*;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.Date;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long commentNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private NextPageMember member;

    @Column(nullable = false)
    private String comment;

    @Column
    private String createdDate = LocalDateTime.now().format(DateTimeFormatter.ofLocalizedDateTime(FormatStyle.SHORT));

    @UpdateTimestamp
    private Date updatedDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "novelEpisode_id")
    private NovelEpisode novelEpisode;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "qna_id")
    private QnA qna;

    public Comment(String comment, NextPageMember member, NovelEpisode episode) {
        this.comment = comment;
        this.member = member;
        this.novelEpisode = episode;
        updateToEpisode();
        updateToMember();
    }
    // qna 답변 댓글 작성할 때 생성자
    public Comment(String comment, NextPageMember member, QnA qna) {
        this.comment = comment;
        this.member = member;
        this.qna = qna;
    }

    public void modifyComment (String comment) {
        this.comment = comment;
    }

    /**
     * 댓글이 달릴 소설 에피소드 엔티티의 댓글 리스트에 해당 댓글을 업데이트
     */
    public void updateToEpisode() {
        this.novelEpisode.updateComment(this);
    }

    /**
     * 댓글을 단 회원 엔티티의 댓글 리스트에 해당 댓글을 업데이트
     */
    public void updateToMember() {
        this.member.updateCommentList(this);
    }

}
