package kr.eddi.demo.novel;

import javax.persistence.*;

@Entity
public class NovelEpisode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private String episodeTitle; // 에피소드별 제목

    @Column
    private String text; // 에피소드 내용

    @Column
    private Boolean needToBuy; // 유료결제여부

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "information_id")
    private NovelInformation information;

    // 여기에 댓글 리스트 매핑
    // @OneToMany
    // private List<코멘트 엔티티> commentList;

}
