import {

} from './mutation-types'
import axios from "axios";

export default{


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