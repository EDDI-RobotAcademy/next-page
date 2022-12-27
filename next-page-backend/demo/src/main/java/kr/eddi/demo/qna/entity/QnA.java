package kr.eddi.demo.qna.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.Date;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor

public class QnA {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long qnaNo;

    @Column(length = 128, nullable = false)
    private String title;

    @Column(length = 32, nullable = false)
    private String category;

    @Lob
    private String content;

    @CreationTimestamp
    private Date regDate;

    @UpdateTimestamp
    private Date updDate;





}
