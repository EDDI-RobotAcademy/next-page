import {
    CHECK_DUPLICATE_EMAIL_TO_SPRING, CHECK_DUPLICATE_NICKNAME_TO_SPRING,

} from './mutation-types'
import axios from "axios";


export default {

    async checkDuplicateEmailToSpring({commit}, payload) { //이메일 중복 확인

        const {email} = payload;

        await axios.post(`http://localhost:7777/member/check-email/${email}`)
            .then((res) => {
                if (res.data) {
                    alert("사용 가능한 이메일입니다.")
                    commit(CHECK_DUPLICATE_EMAIL_TO_SPRING, res.data);
                    console.log("이메일 중복체크 결과값(사용가능)(actions -> res.data: " + res.data)
                } else {
                    alert("중복된 이메일입니다.")
                    commit(CHECK_DUPLICATE_EMAIL_TO_SPRING, res.data);
                    console.log("이메일 중복체크 결과값(중복)(actions -> res.data: " + res.data)
                }
            })
    },
    async checkDuplicateNicknameToSpring({commit}, payload) { // 닉네임 중복 확인
        const {nickName} = payload;

        await axios.post(`http://localhost:7777/member/check-nickname/${nickName}`)
            .then((res) => {
                if (res.data) {
                    alert("사용 가능한 닉네임입니다.")
                    commit(CHECK_DUPLICATE_NICKNAME_TO_SPRING, res.data);
                    console.log(" 닉네임 중복체크 결과값(사용가능)(actions -> res.data: " + res.data)

                } else {
                    alert("사용중인 닉네임입니다.")
                    commit(CHECK_DUPLICATE_NICKNAME_TO_SPRING, res.data);
                    console.log(" 닉네임 중복체크 결과값(중복)(actions -> res.data: " + res.data)
                }
            })
    },
    // eslint-disable-next-line no-empty-pattern
    signUpDataFromSpring({}, payload) { // 회원가입
        const {email, password, nickName} = payload
        axios.post("http://localhost:7777/member/sign-up", {
            email, password, nickName
        })
            .then((res) => {
                alert("회원 가입 완료 하였습니다." + res)
            })
            .catch((res) => {
                alert(res.response.data.message)
            })
    },


}