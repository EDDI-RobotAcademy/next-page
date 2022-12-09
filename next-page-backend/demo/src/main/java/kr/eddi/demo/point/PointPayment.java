package kr.eddi.demo.point;


import kr.eddi.demo.member.entity.member.NextPageMember;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Comment;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Getter
@EntityListeners(AuditingEntityListener.class)
@AllArgsConstructor
@NoArgsConstructor
public class PointPayment {

    @Id
    @Comment("결제 번호")
    private Long payment_id;

    @Column
    private Long payAmount;

    @Column
    private Long chargedPoint;

    @CreatedDate
    private LocalDate pay_date;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private NextPageMember member;


    public PointPayment(NextPageMember member, Long payment_id, Long payAmount, Long chargedPoint){
        this.member = member;
        this.payment_id = payment_id;
        this.payAmount = payAmount;
        this.chargedPoint = chargedPoint;
    }


    /**
     * 매핑된 회원 entity의 list에 해당 주문 내역 entity를 추가합니다.
     */
    public void updateToMember() {
        this.member.updatePointPaymentList(this);
    }


}
