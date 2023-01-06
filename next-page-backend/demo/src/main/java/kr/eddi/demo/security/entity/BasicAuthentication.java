package kr.eddi.demo.security.entity;

import kr.eddi.demo.member.entity.NextPageMember;
import kr.eddi.demo.security.entity.Authentication;
import kr.eddi.demo.utility.encrypt.EncryptionUtil;
import kr.eddi.demo.utility.password.PasswordHashConverter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;

@Entity
@ToString(callSuper = true)
@NoArgsConstructor
@DiscriminatorValue(Authentication.BASIC_AUTH)

public class BasicAuthentication extends Authentication {

    @Setter
    @Column(nullable = false)
    @Convert(converter = PasswordHashConverter.class)
    private String password;

    public BasicAuthentication(NextPageMember member, String authenticationType, String password) {
        super(member, authenticationType);
        this.password = password;
    }

    public boolean isRightPassword(String plainCheck) {
        return EncryptionUtil.checkValidation(plainCheck, password);
    }



}
