package kr.eddi.demo.pedometer.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import kr.eddi.demo.member.entity.NextPageMember;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;

@Entity
@NoArgsConstructor
@Getter
@ToString
public class Pedometer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private String createdDate =
            LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

    @Column
    private Boolean isTaken;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @JoinColumn(name = "member_id")
    private NextPageMember member;

    public Pedometer(NextPageMember member) {
        this.isTaken = true;
        this.member = member;
        updateToMember();
    }

    /**
     * 포인트를 수령한 회원 회원 엔티티에 만보기 포인트 수령 기록 업데이트
     */
    public void updateToMember() {
        this.member.updatePedometerRecordList(this);
    }
}
