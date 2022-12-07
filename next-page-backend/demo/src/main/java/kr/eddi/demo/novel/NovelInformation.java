package kr.eddi.demo.novel;


import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class NovelInformation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title; // 제목

    private String publisher; // 출판사

    private String author; // 작가

    private String category; // 카테고리, 따로 entity로 분류할지, 리스트로 여러개를 넣을 수 있게 할 지 고민을 해봐야할 듯

    private String introduction; // 소개문구

    private Long purchasePoint; // 유료 구매시의 포인트

    @OneToMany(mappedBy = "information", fetch = FetchType.LAZY)
    private List<NovelEpisode> episodeList = new ArrayList<>();


}
