package kr.eddi.demo.episode_payment.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.novel.entity.NovelEpisode;
import kr.eddi.demo.novel.entity.NovelInformation;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Getter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class EpisodePayment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @CreatedDate
    private LocalDate paymentDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    @JsonIgnore
    private NextPageMember member;

    @Column
    private Long episodeId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "novel_id")
    @JsonIgnore
    private NovelInformation novel;


    public EpisodePayment(NextPageMember member, Long episodeId, NovelInformation novel) {
        this.member = member;
        this.episodeId = episodeId;
        this.novel = novel;
    }

    public void updateToMember() {
        this.member.updateEpisodePayments(this);
    }

}
