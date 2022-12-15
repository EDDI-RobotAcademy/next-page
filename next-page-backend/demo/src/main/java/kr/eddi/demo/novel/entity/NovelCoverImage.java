package kr.eddi.demo.novel.entity;

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

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "information_id")
    private NovelInformation information;

    public NovelCoverImage(String originalName, String reName, NovelInformation information) {
        this.originalName = originalName;
        this.reName = reName;
        this.information = information;
    }

    public void updateToInformation() {
        this.information.updateCoverImage(this);
    }

}
