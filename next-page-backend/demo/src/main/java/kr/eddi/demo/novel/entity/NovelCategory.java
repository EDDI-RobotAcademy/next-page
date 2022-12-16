package kr.eddi.demo.novel.entity;


import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@NoArgsConstructor
@Getter
public class NovelCategory {

    @Id
    private Long id;

    @Column
    private String categoryName;

    @OneToMany(mappedBy = "category", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<NovelInformation> informationList = new ArrayList<>();

    public NovelCategory(Long id, String categoryName) {
        this.id = id;
        this.categoryName = categoryName;
    }

    /**
     * 카테고리에 해당하는 소설 정보를 소설 정보 리스트에 추가합니다.
     * @param novelInformation
     */
    public void updateNovelInformation(NovelInformation novelInformation) {
        this.informationList.add(novelInformation);
    }
}
