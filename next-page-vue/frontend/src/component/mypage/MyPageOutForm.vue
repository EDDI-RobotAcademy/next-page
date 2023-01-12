<template>
<div>
  <v-container>
    <v-row justify="center">
      <div style="font-size:20pt;">
        <v-icon large color="blue">mdi-information-outline</v-icon>

        NEXT-PAGE 에서 탈퇴하시길 원하십니까?

      </div>
    </v-row>
    <v-row justify="center">
      <v-col cols="12" class="content">
        <div>
          <b>📚 회원탈퇴시 회원정보는 모두 <span class="point">삭제</span>되며, 재가입시에도 복원되지 않습니다. </b> <p/>
          <br>

          <div class="pl-7 pr-7 mb-7">
            ️️ 회원탈퇴 후 포인트는 사용하실수 없습니다.<p/>

            ️️ 회원탈퇴 후 구매한 목록들을 열람 하실수 없습니다. <p/>

            ️️ 회원탈퇴 후 재가입시 회원정보가 복원되지 않습니다.. <p/>


          </div>

          <br>
         <b>📚 탈퇴 후 정보보관</b> <p/> <br>
          <div class="pl-7 pr-7">
            전자상거래 등에서의 소비자 보호에 관한 법률 제6조에 의거 이메일 등 거래의 주체를 식별할 수 있는 정보에 한하여 서비스<p></p>
            이용에 관한 동의를 철회한 경우에도 이를 보존할 수 있으며, 동법 시행령 제6조에 의거 다음과 같이 거래 기록 보관합니다.

            <p/>
            표시, 광고에 관한 기록 : 6개월 <p/>
            계약 또는 청약철회 등에 관한 기록 : 5년 <p/>
            대금결제 및 재화등의 공급에 관한 기록 : 5년 <p/>
            소비자의 불만 또는 분쟁처리에 관한 기록 : 3년 <p/>
          </div>
        </div>
      </v-col>
    </v-row>

    <br><br>

    <v-layout justify-end style="text-align: center">
      <div style="margin-top: 22px; color: #6699FF; ">
        <h3>주의사항을 확인하였습니다. 탈퇴를 진행합니다.</h3>
      </div>
      <div>
        <v-checkbox v-model="consentCheckStatus">
        </v-checkbox>
      </div>

    </v-layout>
    <br><br>

    <div align="center">
      <v-btn
          class="white--text"
          width="180px"
          height="50px"
          style="background-color: #6699FF"
          elevation="0"
          :disabled="!consentCheckStatus"
          @click="accountDrop"
      >
        회원탈퇴
      </v-btn>
    </div>

  </v-container>
</div>
</template>

<script>
import {mapActions} from "vuex";

export default {
  name: "MyPageOutForm",
  data() {
    return {
      consentCheckStatus: false
    }
  },
  methods: {
    ...mapActions([
      'requestDeleteMemberToSpring'
    ]),

    async accountDrop() {
      const userToken = this.$store.state.userToken;
      await this.requestDeleteMemberToSpring({userToken})
      await this.$router.push({name: "home"})
      localStorage.removeItem("vuex")
      alert("회원탈퇴가 완료됐습니다. 서비스를 이용해 주셔서 감사합니다.")

    }


  }
}
</script>

<style scoped>

.content {
  border: 1px solid rgb(189, 189, 189);
  background-color: rgb(241, 241, 241);
  margin-top: 50px;
  padding: 30px;
  max-width: 1000px;
}

.point {
  color: rgb(255, 87, 87)
}




</style>