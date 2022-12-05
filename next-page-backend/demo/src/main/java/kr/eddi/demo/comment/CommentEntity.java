package kr.eddi.demo.comment;

import com.fasterxml.jackson.annotation.JsonIgnore;
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

//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "board_no")
//    private WebNovelEntity webNovelEntity;

    public CommentEntity(String comment, String commentWriter) {
        this.comment = comment;
        this.commentWriter = commentWriter;
    }


}
