<template>

  <div>
    <SignInForm @submit="onSubmit"/>
  </div>

</template>

<script>
import SignInForm from "@/component/account/SignInForm";
import cookies from 'vue-cookies';
import Vue from "vue";
import {mapActions} from "vuex";

Vue.use(cookies);

export default {
  name: "SignInView",
  components: {
    SignInForm
  },

  methods: {

    ...mapActions(['requestSignInToSpring']),
    async onSubmit(payload) {
      const {email,password} = payload
      await this.requestSignInToSpring({email,password})
      await this.$router.push({ name: 'home' })

    },
  }


}
</script>

<style scoped>

</style>