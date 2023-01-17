package kr.eddi.demo.notice.entity;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;

@Entity
@NoArgsConstructor
@Getter
@ToString

public class Notice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long noticeNo;

    @Column(length = 128, nullable = false)
    private String title;

    @Column
    private String content;

    @Column
    private String createdDate =
            LocalDateTime.now().format(DateTimeFormatter.ofLocalizedDateTime(FormatStyle.SHORT));

    @Column
    private Long novelInfoId;

    @Column
    private NoticeCategory noticeCategory;

    public Notice(String title, String content, NoticeCategory category, Long novelInfoId) {
        this.title = title;
        this.content = content;
        this.noticeCategory = category;
        this.novelInfoId = novelInfoId;
    }

}
