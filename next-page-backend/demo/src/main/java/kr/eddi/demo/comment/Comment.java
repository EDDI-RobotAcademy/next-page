package kr.eddi.demo.comment;


import kr.eddi.demo.member.entity.member.NextPageMember;
import kr.eddi.demo.novel.entity.NovelEpisode;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
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
@Data
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

    public Comment(String comment, NextPageMember member, NovelEpisode episode) {
        this.comment = comment;
        this.member = member;
        this.novelEpisode = episode;
        updateToEpisode();
        updateToMember();
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
