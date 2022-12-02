package kr.eddi.demo.member.entity.member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import javax.persistence.*;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class MemberProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id = null;

    private String nickName;


    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private NextPageMember member;

    public MemberProfile (String nickName) {
        this.nickName = nickName;

    }

    public void modifyNickname(String nickName) {
        this.nickName = nickName;
    }


}
