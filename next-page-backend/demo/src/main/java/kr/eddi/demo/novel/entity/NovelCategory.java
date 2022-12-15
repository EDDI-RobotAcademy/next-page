package kr.eddi.demo.novel.entity;


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
    private List<NovelInformation> informationList = new ArrayList<>();

    public NovelCategory(Long id, String categoryName) {
        this.id = id;
        this.categoryName = categoryName;
    }

    public void updateNovelInformation(NovelInformation novelInformation) {
        this.informationList.add(novelInformation);
    }
}
