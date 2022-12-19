n<template>
  <div class="d-flex justify-center">
    <v-card elevation="0">
      <v-card-text class="text-lg-center">
        <h2>포인트 충전</h2>
      </v-card-text>
      <v-row justify="center">
        <v-col cols="auto">
          <v-card>
            <v-card-text class="text-lg-center">
              <h4> 현재 보유 캐시 : {{ memberOwnCash.toLocaleString() }} point </h4>
            </v-card-text>
          </v-card>
          <v-card width="500px" class="px-10 py-2">
            <v-radio-group
                v-model="checkedPrice">
              <v-radio color="#6699FF"
                       v-for="option in priceOption"
                       :key="option.point"
                       :label="option.point"
                       :value="option.price"/>
            </v-radio-group>
          </v-card>
          <v-card>
            <v-card-text class="text-lg-center">
              <h3> 결제 금액 : {{ this.checkedPrice.toLocaleString() }} 원 </h3>
            </v-card-text>
          </v-card>

          <div class="button pt-2 d-flex justify-center">
            <!-- 결제 테스트 진행용 -->
            <v-btn elevation="0" color="#6699FF" class="white--text mx-1" @click="toKakaoPay">
              카카오
            </v-btn>

            <!-- 테스트중에도 실결제 필요하니 이용 X -->
            <v-btn elevation="0" color="#6699FF" class="white--text mx-1" @click="toInisisPayment">
              통합 결제
            </v-btn>

          </div>
        </v-col>
      </v-row>
    </v-card>
  </div>
</template>

<script>

export default {
  name: "PointChargeForm",
  data() {
    return {
      memberOwnCash: 1000,
      priceOption: [
        { point: "500 p", price: 500},
        { point: "1000 p", price: 1000},
        { point: "3000 p", price: 3000},
        { point: "5000 p", price: 5000},
        { point: "10000 p", price: 10000},
        { point: "30000 p", price: 30000},
        { point: "50000 p", price: 50000},
        { point: "100000 p", price: 100000},
      ],
      checkedPrice: 0,
    }
  },
  methods: {

    toKakaoPay() {
      if (this.checkedPrice <= 0) {
        alert("결제금액을 선택해주세요!")
      } else {
        const IMP = window.IMP;
        let payment_id = Date.now(); // 주문정보생성용

        IMP.init("imp46705714"); // 가맹점 번호
        IMP.request_pay({
          pg: "kakaopay.TC0ONETIME",
          pay_method: 'card',
          merchant_uid: payment_id, //고유 주문번호
          name: 'Next Page 포인트 충전',
          amount: this.checkedPrice, // 결제 금액
          buyer_email: 'test@gmail.com', // 구매자 메일 받기
          buyer_name: '구매자이름', // 구매자 이름 받기
      /*  m_redirect_url: '{모바일에서 결제 완료 후 리디렉션 될 URL}', */
        }, rsp => { // callback
          console.log(rsp);
          if (rsp.success){
            /* 주문번호 props로 받아서 주문 완료 페이지 작성하고 싶으나 현재는 이슈 발생중
            let paymentData = { payment_id: rsp.merchant_uid, }
            this.$router.push({ name: "PaymentSuccess", params: { paymentData}}) */

            this.$router.push("/payment-success")
            console.log("결제 성공");

          } else {
            console.log("결제 실패");
          }
        });
      }
    }, //kakaopay

    toInisisPayment() {
      if (this.checkedPrice <= 0) {
        alert("결제금액을 선택해주세요!")
      } else {
        const IMP = window.IMP;
        let order_id = Date.now();

        IMP.init("imp46705714");
        IMP.request_pay({
          pg: "html5_inicis.INIpayTest", //테스트 시 html5_inicis.INIpayTest 기재
          pay_method: 'card',
          merchant_uid: "point-" + order_id, //고유 주문번호
          name: 'Next Page 포인트 충전',
          amount: this.checkedPrice,
          buyer_email: 'test@gmail.com',
          buyer_name: '구매자이름',
          buyer_tel: '010-1234-5678',   //필수 파라미터
          m_redirect_url: '{모바일에서 결제 완료 후 리디렉션 될 URL}',
          escrow: true, //에스크로 결제인 경우 설정
          bypass: {
            acceptmethod: 'cardpoint', // 카드포인트 사용시 설정(PC)
            P_RESERVED: 'cp_yn=Y',     // 카드포인트 사용시 설정(모바일)
          },
        }, rsp => { // callback
          console.log(rsp);
          if (rsp.success) {
            this.$router.push("/payment-success")
            console.log("결제 성공");
          } else {
            console.log("결제 실패");
          }
        });
      }
    }, //toKGInisis

  } // methods
}
</script>

<style scoped>

</style>