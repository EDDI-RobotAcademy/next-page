<template>
  <div style="font-family: Arial">
    <br><br><br><br>
    <v-row justify="center">

      <v-col cols="3" style="padding-bottom: 90px">

        <br/>

        <v-form @submit.prevent="onSubmit">
          <div>
            <v-row justify="center" class="logo">
              <div style="color:#6699FF">NEXT-PAGE</div>
            </v-row>


          </div>
          <v-divider></v-divider>
          <br/>
          <br/>

          <div class="d-flex">
            <v-text-field v-model="email" label="이메일" color="#6699FF"
                          :rules="email_rule" clearable prepend-icon="mdi-account-arrow-right" outlined dense/>
          </div>

          <div class="d-flex">
            <v-text-field v-model="password" label="비밀번호" type="password" color="#6699FF"
                          :rules="password_rule" clearable prepend-icon="mdi-key" outlined dense/>
          </div>

          <v-btn type="submit" block x-large color="#6699FF"
                 class="mt-7"
                 :disabled="false">
            <div class="color">
              로그인
            </div>


          </v-btn>



          <br/>
          <v-divider></v-divider>
          <br/>

          <div align="center">
            <h5>아직 회원이 아니신가요? <a href="Member-Join-Form" class="textLink">회원가입</a></h5>
          </div>
        </v-form>
      </v-col>
    </v-row>
  </div>


</template>

<script>
export default {
  name: "SignInForm",
  data() {
    return {
      email: "",
      password: "",
      email_rule: [
        v => !!v || '이메일을 입력해주세요.',
        v => {
          const replaceV = v.replace(/(\s*)/g, '')
          const pattern = /^(([^<>()[\]\\.,;:\s@]+(\.[^<>()[\]\\.,;:\s@]+)*)|(.+))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
          return pattern.test(replaceV) || '이메일 형식을 입력하세요.'
        }
      ],
      password_rule: [
        v => this.state === 'ins' ? !!v || '패스워드는 필수 입력사항입니다.' : true,
        v => !(v && v.length >= 15) || '패스워드는 15자 이상 입력할 수 없습니다.',
        v => !(v && v.length <= 7) || '패스워드는 8자 이하 입력할 수 없습니다.',
      ],
    }
  },
  methods: {
    onSubmit() {
      const {email, password} = this
      this.$emit("submit", {email, password})
    }
  }


}
</script>

<style scoped>

.textLink {
  color: #6699FF;
}


.logo {
  font-size: 39pt;
  margin-top: 5%;
  margin-bottom: 3%;
  font-family: 'Pacifico', cursive;
}

.color {

  color: white;
  font-size: 13pt;


}


</style>