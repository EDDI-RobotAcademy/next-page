import {
    CHECK_DUPLICATE_EMAIL_TO_SPRING,
    CHECK_DUPLICATE_NICKNAME_TO_SPRING,
    REQUEST_CURRENT_USER_NICKNAME_FROM_SPRING,
    REQUEST_UPLOADER_NOVEL_INFO_LIST,


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
    }






}