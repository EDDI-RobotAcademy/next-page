<template>

  <div>
    <SignInForm @submit="onSubmit"/>
  </div>

</template>

<script>
import SignInForm from "@/component/account/SignInForm";
import cookies from 'vue-cookies';
import axios from "axios";
import Vue from "vue";
Vue.use(cookies);


export default {
  name: "SignInView",
  components: {
    SignInForm
  },
  data() {
    return {
      isLogin: false
    }
  },
  mounted() {
    if (this.$store.state.isAuthenticated != false) {
      this.isLogin = true;
    } else {
      this.isLogin = false;
    }
  },

  methods: {
    onSubmit(payload) {
      if (!this.isLogin) {
        const {email, password} = payload
        axios.post("http://localhost:7777/member/sign-in", {email, password})
            .then((res) => {
              if (res.data) {

                console.log(res.data)
                alert("로그인 성공하였습니다.")
                this.$store.state.isAuthenticated = true
                this.$cookies.set("user", res.data, 3600);
                localStorage.setItem("userInfo", JSON.stringify(res.data))
                this.isLogin = true
                this.$router.push("/")
              } else {
                alert("아이디 혹은 비밀번호가 일치하지 않거나 존재 하지 않습니다 :D")
              }
            })
            .catch((res) => {
              alert(res.response.data.message)
            })
      } else {
        console.log(this.$store.state.isAuthenticated)
        alert("이미 로그인 되어 있습니다:D")
      }
    }


  }


}
</script>

<style scoped>

</style>