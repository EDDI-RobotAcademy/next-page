package kr.eddi.demo.member.entity.member;

import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.point.PointPayment;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.*;

@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor

public class NextPageMember {

    @Id
    @Getter
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Getter
    @Column(nullable = false)
    private String email;

    @OneToOne(mappedBy = "memberInfo", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private MemberProfile profile;

    @Getter
    @Column
    private Long point;

    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY)
    private Set<Authentication> authentications = new HashSet<>();

    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY)
    private List<PointPayment> pointPaymentList = new ArrayList<>();

    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY)
    private List<NovelInformation> novelInformationList = new ArrayList<>();

    public NextPageMember(String email, MemberProfile profile) {
        this.email = email;
        this.profile = profile;
        this.point = Long.valueOf(0);
        profile.setMemberInfo(this);
    }

    public boolean isRightPassword(String plainToCheck) {
        final Optional<Authentication> maybeBasicAuth = findBasicAuthentication();

        if (maybeBasicAuth.isPresent()) {
            final BasicAuthentication auth = (BasicAuthentication) maybeBasicAuth.get();
            return auth.isRightPassword(plainToCheck);
        }

        return false;
    }

    private Optional<Authentication> findBasicAuthentication() {
        return authentications
                .stream()
                .filter(auth -> auth instanceof BasicAuthentication)
                .findFirst();
    }


    /**
     * 회원 정보에 결제 내역을 업데이트 합니다.
     *
     * @param pointPayment 결제 내역 정보 entity
     */
    public void updatePointPaymentList(PointPayment pointPayment) {
        this.pointPaymentList.add(pointPayment);
    }

    /**
     * 기존 포인트에 새로 충전한 포인트를 추가합니다.
     *
     * @param chargedPoint 충전될 포인트
     */
    public void addChargedPoint(Long chargedPoint) {
        this.point += chargedPoint;
    }


    /**
     * 회원 정보에 등록한 소설 리스트를 업데이트 합니다.
     *
     * @param information 소설 정보 entity
     */
    public void updateNovelInformationList(NovelInformation information) {
        this.novelInformationList.add(information);
    }
}