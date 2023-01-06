package kr.eddi.demo.episode_payment.entity;

import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.novel.entity.NovelEpisode;
import lombok.Getter;
import lombok.NoArgsConstructor;
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
    private NextPageMember member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "novelEpisode_id")
    private NovelEpisode novelEpisode;

    public EpisodePayment(NextPageMember member, NovelEpisode episode) {
        this.member = member;
        this.novelEpisode = episode;
    }

    public void updateToMember() {
        this.member.updateEpisodePayments(this);
    }
    public void updateToEpisode() {
        this.novelEpisode.updateEpisodePayments(this);
    }


}
