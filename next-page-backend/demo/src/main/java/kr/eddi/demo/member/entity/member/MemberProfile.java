package kr.eddi.demo.member.entity.member;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@AllArgsConstructor
@NoArgsConstructor
public class MemberProfile {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id = null;

    @Column(nullable = false)
    private String nickName;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private NextPageMember memberInfo;

    public MemberProfile(String nickName) {
        this.nickName = nickName;
    }

    public static MemberProfile of (String nickName) {
        return new MemberProfile(nickName);
    }

    public void setMemberInfo(NextPageMember memberInfo) {
        this.memberInfo = memberInfo;
    }


}