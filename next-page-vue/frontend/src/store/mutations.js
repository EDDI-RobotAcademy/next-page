import {
    CHECK_DUPLICATE_EMAIL_TO_SPRING,
    CHECK_DUPLICATE_NICKNAME_TO_SPRING, REQUEST_BOARD_FROM_SPRING, REQUEST_BOARD_LIST_FROM_SPRING,
    REQUEST_CURRENT_USER_NICKNAME_FROM_SPRING, REQUEST_NOVEL_EPISODE_LIST, REQUEST_SIGN_IN_TOKEN_FROM_SPRING,
    REQUEST_UPLOADER_NOVEL_INFO_LIST, SIGN_IN_VALUE, USER_TOKEN,
    REQUEST_CURRENT_USER_NICKNAME_FROM_SPRING, REQUEST_NOVEL_EPISODE_LIST,
    REQUEST_UPLOADER_NOVEL_INFO_LIST,REQUEST_NOVEL_LIST_TO_SPRING


} from './mutation-types'


export default {
    [CHECK_DUPLICATE_EMAIL_TO_SPRING](state, passingData) {
        state.emailPassValue = passingData
    },

    [CHECK_DUPLICATE_NICKNAME_TO_SPRING](state, passingData) {
        state.nicknamePassValue = passingData;
    },
    [REQUEST_CURRENT_USER_NICKNAME_FROM_SPRING](state, passingData) {
        state.currentUserNickname = passingData;
    },


    [REQUEST_UPLOADER_NOVEL_INFO_LIST] (state, passingData) {
        state.uploaderNovelInfoList = passingData
    },
    [REQUEST_NOVEL_EPISODE_LIST] (state, passingData) {
        state.novelEpisodeList = passingData
    },

    [REQUEST_BOARD_LIST_FROM_SPRING](state, passingData) {
        state.qnas = passingData
    },


    [REQUEST_BOARD_FROM_SPRING] (state, passingData) {
        state.qna = passingData
    },


    [REQUEST_SIGN_IN_TOKEN_FROM_SPRING] (state, passingData) {
        state.memberInfoAfterSignIn = passingData
    },

    [SIGN_IN_VALUE](state, passingData) {
        state.signInValue = passingData
    },
    [USER_TOKEN](state, passingData) {
        state.userToken = passingData
    },


    [REQUEST_NOVEL_LIST_TO_SPRING] (state, passingData) {
        state.allNovelLists = passingData
    },




}