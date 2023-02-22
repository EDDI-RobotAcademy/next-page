import {
    CHECK_DUPLICATE_EMAIL_TO_SPRING,
    CHECK_DUPLICATE_NICKNAME_TO_SPRING, REQUEST_BOARD_FROM_SPRING,
    REQUEST_BOARD_LIST_FROM_SPRING, REQUEST_NOVEL_EPISODE_LIST, REQUEST_SIGN_IN_TOKEN_FROM_SPRING,
    REQUEST_NOVEL_LIST_TO_SPRING,
    REQUEST_UPLOADER_NOVEL_INFO_LIST,

} from './mutation-types'
import axios from "axios";
import states from "@/store/states";
import store from "@/store/index";
import {memberCheckDuplicateEmailService, memberCheckDuplicateNicknameService} from "@/api/services/userServices";


export default {


    requestUploaderNovelInfoListToSpring({commit}, payload) {
        console.log("requestUploaderNovelInfoListToSpring()")

        const {member_id, page, size} = payload
        return axios.post(`http://localhost:7777/novel/${member_id}/information-list`, {page, size})
            .then((res) => {
                commit(REQUEST_UPLOADER_NOVEL_INFO_LIST, res.data)
            })
            .catch((error) => {
                alert(error)
            })
    },

    requestNovelListToSpring({commit}) {
        console.log("requestNovelListToSpring()")

        return axios.get(`http://localhost:7777/novel/all-novel-list`)
            .then((res) => {
                commit(REQUEST_NOVEL_LIST_TO_SPRING, res.data)
                console.log("res.data : " + res.data)
            })
            .catch((error) => {
                alert(error)
            })
    },

    async checkDuplicateEmailToSpring({commit}, payload) { //이메일 중복 확인

        const {email} = payload;

        await memberCheckDuplicateEmailService(email)
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

        await memberCheckDuplicateNicknameService(nickName)
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
    requestPayAndChargePointToSpring({}, payload) {
        console.log("requestPayAndChargePointToSpring()")

        const {member_id, payment_id, amount, point} = payload
        return axios.post('http://localhost:7777/point/pay-charge', {member_id, payment_id, amount, point})
            .then((res) => {
                if (res.data) {
                    alert("포인트 충전이 완료되었습니다.")
                }
            })
            .catch((error) => {
                alert(error)
            })
    },

    requestBoardListFromSpring({commit}) {
        console.log('requestBoardListFromSpring()')

        return axios.get('http://localhost:7777/qna/list')
            .then((res) => {
                commit(REQUEST_BOARD_LIST_FROM_SPRING, res.data)
            })
    },

    // eslint-disable-next-line no-empty-pattern
    requestCreateBoardContentsToSpring({}, payload) {
        console.log('requestCreateBoardContentsToSpring()')

        const {title, category, content} = payload
        return axios.post('http://localhost:7777/qna/register',
            {title, category, content})
            .then(() => {
                alert('📚 QnA를 등록 하였습니다. 📚')
            })
    },


    requestBoardFromSpring({commit}, qnaNo) {
        console.log('requestBoardFromSpring()')

        return axios.get(`http://localhost:7777/qna/${qnaNo}`)
            .then((res) => {
                commit(REQUEST_BOARD_FROM_SPRING, res.data)
            })
    },


    // eslint-disable-next-line no-empty-pattern
    requestDeleteBoardToSpring({}, qnaNo) {
        console.log('requestDeleteBoardToSpring()')

        return axios.delete(`http://localhost:7777/qna/${qnaNo}`)
            .then(() => {
                alert('📚 QnA를 삭제 하였습니다.📚')
            })
    },
    // eslint-disable-next-line no-empty-pattern
    requestBoardModifyToSpring({}, payload) {
        console.log('requestBoardModifyToSpring()')

        const {title, content, qnaNo, category, regDate} = payload

        return axios.put(`http://localhost:7777/qna/${qnaNo}`,
            {title, content, category, regDate})
            .then(() => {
                alert('📚 QnA를 수정 하였습니다. 📚 ')
            })
    },


    requestEpisodeListToSpring({commit}, payload) {

        console.log("requestPayAndChargePointToSpring()")

        const {novel_info_id, page, size } = payload

        return axios.post(`http://localhost:7777/novel/episode-list/${novel_info_id}`, { page, size })
            .then((res) =>{
                console.log(res.data)
                commit(REQUEST_NOVEL_EPISODE_LIST, res.data)
            })
            .catch((error) => {
                alert(error.message)
            })
    },


    async requestSignInToSpring({commit}, payload) {
        console.log('requestSignInToSpring')

        const {email, password} = payload

        await axios.post('http://localhost:7777/member/sign-in', {email, password})
            .then((res) => {
                if (localStorage.getItem("userToken") == null) {
                    alert("로그인 되었습니다.📚 ")
                    commit(REQUEST_SIGN_IN_TOKEN_FROM_SPRING, res.data)
                    states.userToken = res.data.userToken
                    console.log("멤버 닉네임 :"+ res.data.userNickName)
                    console.log("멤버 이메일 :"+ res.data.userEmail)
                    console.log("멤버 포인트 :"+ res.data.userPoint)
                    console.log("멤버 아이디값 :"+ res.data.userId)


                    if (localStorage.getItem("userToken") != states.userToken) {
                        store.commit("USER_TOKEN", res.data.userToken)
                    }
                    store.commit('SING_IN_VALUE', true)

                } else {
                    alert("이미 로그인 되어있습니다.📚 ")
                }
            })
            .catch(() => {
                alert("아이디 혹은 비밀번호가 존재하지 않거나 틀렸습니다.📚 ")
            })
    },














}