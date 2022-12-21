import {
    CHECK_DUPLICATE_EMAIL_TO_SPRING, CHECK_DUPLICATE_NICKNAME_TO_SPRING, REQUEST_UPLOADER_NOVEL_INFO_LIST,

} from './mutation-types'
import axios from "axios";


export default{



    requestUploaderNovelInfoListToSpring({commit}, payload) {
        console.log("requestUploaderNovelInfoListToSpring()")

        const { member_id, page, size } = payload
        return axios.post(`http://localhost:7777/novel/${member_id}/information-list`, { page, size })
            .then((res) => {
                commit(REQUEST_UPLOADER_NOVEL_INFO_LIST, res.data)
            })
            .catch((error) => {
                alert(error)
            })
    },

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

    // eslint-disable-next-line no-empty-pattern
    requestPayAndChargePointToSpring({ }, payload) {
        console.log("requestPayAndChargePointToSpring()")

        const { member_id, payment_id, amount, point } = payload
        return axios.post('http://localhost:7777/point/pay-charge', { member_id, payment_id, amount, point})
            .then((res) => {
                if(res.data) {
                    alert("포인트 충전이 완료되었습니다.")
                }
            })
            .catch((error) => {
                alert(error)
            })
    }




    /*requestUploaderNovelInfoListToSpring() {

        console.log("requestUploaderNovelInfoListToSpring()")
        return axios.get
    }*/

}