package kr.eddi.demo.member.entity;

import kr.eddi.demo.comment.entity.Comment;
import kr.eddi.demo.episode_payment.entity.EpisodePayment;
import kr.eddi.demo.novel.entity.NovelInformation;
import kr.eddi.demo.payment.entity.PointPayment;
import kr.eddi.demo.security.entity.Authentication;
import kr.eddi.demo.security.entity.BasicAuthentication;
import lombok.*;

import javax.persistence.*;
import java.util.*;

@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor



public class NextPageMember {

    @Id
    @Getter
    @Setter
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Getter
    @Setter
    @Column(nullable = false)
    private String email;


    @Getter
    @Setter
    @Column(nullable = false)
    private String nickName;

    @Getter
    @Column
    private Long point;

    @OneToMany(mappedBy = "member", fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
    private Set<Authentication> authentications = new HashSet<>();

    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY)
    private List<PointPayment> pointPaymentList = new ArrayList<>();

    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY)
    private List<NovelInformation> novelInformationList = new ArrayList<>();

    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY)
    private List<Comment> commentList = new ArrayList<>();

    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY)
    private List<EpisodePayment> episodePayments = new ArrayList<>();


    public NextPageMember(String email, String nickName) {
        this.email = email;
        this.nickName = nickName;
        this.point = Long.valueOf(0);
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

    /**
     * 회원이 쓴 댓글 리스트를 업데이트 합니다.
     *
     * @param comment 쓴 댓글
     */
    public void updateCommentList(Comment comment) {
        this.commentList.add(comment);
    }
    // 소설 에피소드 구매가 완료되면 EpisodePayment 객체를 구매 내역 리스트에 추가
    public void updateEpisodePayments(EpisodePayment episodePayment) {
        this.episodePayments.add(episodePayment);
    }

    public void payPoint(Long episodePrice) { this.point -= episodePrice; }
}