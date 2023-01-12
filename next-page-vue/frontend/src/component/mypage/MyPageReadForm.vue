<template>
  <div>


    <v-container>


      <v-card-title><b class="mt-5 ml-5"> {{ this.userNickName }} 님의 마이페이지
        <v-icon>mdi-account-check</v-icon>
      </b></v-card-title>

      <br>
      <hr color="#6699FF" width="100%">
      <br><br>

      <div class="right_content">

        <v-container style="text-align: center">

          <table style="table-layout: fixed; width: 100%; box-sizing: border-box">


            <tr>
              <th class="th-style">
                이메일
              </th>

              <td>
                {{ this.userEmail }}

              </td>

            </tr>

            <br><br>

            <tr>
              <th class="th-style">
                닉네임
              </th>
              <td>
                {{ this.userNickName }}
              </td>
            </tr>


            <br><br>

            <tr>
              <th class="th-style">
                잔여 포인트
              </th>
              <td>
                {{ this.userPoint }}
              </td>
            </tr>

            <br><br>





          </table>
        </v-container>
      </div>

    </v-container>
  </div>
</template>

<script>
export default {
  name: "MyPageReadForm",


  data() {
    return {
      userNickName: this.$store.state.memberInfoAfterSignIn.userNickName,
      userEmail: this.$store.state.memberInfoAfterSignIn.userEmail,
      userPoint: this.$store.state.memberInfoAfterSignIn.userPoint,

      nickname: '',
      nicknamePass: false,
      nicknameDuplicatePass: false,
      nickname_rule: [
        v => !!v || '변경할 닉네임을 입력해주세요.',
        v => {
          const pattern = /^[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$/
          return pattern.test(v) || '특수문자는 입력할 수 없습니다.'
        },
        v => !(v && v.length >= 20) || '닉네임은 30자 이상 입력할 수 없습니다.',
      ],
    }

  },

  methods: {},

  async mounted() {
    this.userNickName = this.$store.state.memberInfoAfterSignIn.userNickName
    this.userEmail = this.$store.state.memberInfoAfterSignIn.userEmail
    this.userPoint = this.$store.state.memberInfoAfterSignIn.userPoint
  },


}
</script>

<style scoped>

</style>