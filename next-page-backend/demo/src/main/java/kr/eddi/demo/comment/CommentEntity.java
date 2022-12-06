package kr.eddi.demo.comment;

import kr.eddi.demo.episode.NovelEpisodeEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
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
public class CommentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long commentNo;

    @Column(nullable = false)
    private String commentWriter;

    @Column(nullable = false)
    private String comment;

    @CreationTimestamp
    private String createdDate = LocalDateTime.now().format(DateTimeFormatter.ofLocalizedDateTime(FormatStyle.SHORT));

    @UpdateTimestamp
    private Date updatedDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "novel_episode_id")
    private NovelEpisodeEntity novelEpisodeEntity;

    public CommentEntity(String comment) {
        this.comment = comment;
    }

    public void modifyComment (String comment) {
        this.comment = comment;
    }
}
