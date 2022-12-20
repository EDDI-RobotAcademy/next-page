<template>
<div>

  <SignUpForm @submit="onSubmit"/>
</div>
</template>

<script>
import SignUpForm from "@/component/account/SignUpForm";
import {mapActions} from "vuex";

export default {
  name: "SignUpView",
  components: {
    SignUpForm
  },
  methods:{
    ...mapActions([
      'signUpDataFromSpring'
    ]),
    async onSubmit(payload) {
      const {email, password, nickName} = payload;
      await this.signUpDataFromSpring({email, password, nickName})
      await this.$router.push({name:'SignIn-View'})
    }
  }
}
</script>

<style scoped>

</style>