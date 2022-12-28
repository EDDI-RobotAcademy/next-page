package kr.eddi.demo.novel.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@Getter
public class NovelCoverImage {

    @Id
    @Column(name = "cover_image_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private String originalName;

    @Column
    private String reName;

    @OneToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @JoinColumn(name = "information_id")
    private NovelInformation information;

    public NovelCoverImage(String originalName, String reName, NovelInformation information) {
        this.originalName = originalName;
        this.reName = reName;
        this.information = information;
    }

    public void modify(String originalName, String reName) {
        this.originalName = originalName;
        this.reName = reName;
    }

    /**
     * 맵핑된 소설 정보 엔티티에 표지 정보를 업데이트 합니다.
     */
    public void updateToInformation() {
        this.information.updateCoverImage(this);
    }

}
