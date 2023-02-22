import mainRequest from "@/api/mainRequest";


export const memberCheckDuplicateEmailService = async (email) => {
    const res = await mainRequest.post(`/member/check-email/${email}`)
    return res.data
}

export const memberCheckDuplicateNicknameService = async (nickname) => {
    const res = await mainRequest.post(`/member/check-nickname/${nickname}`)
    return res.data
}