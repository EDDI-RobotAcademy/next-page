<template>
<div>


  <div align="center">

    <QnARegister @submit="onSubmit"/>
  </div>


</div>
</template>

<script>
import {mapActions} from "vuex";
import QnARegister from "@/component/mypage/qna/QnARegister";


export default {
  name: "QnARegisterView",
  components: {QnARegister},
  methods: {
    ...mapActions([
      'requestCreateBoardContentsToSpring'
    ]),
    async onSubmit (payload) {
      await this.requestCreateBoardContentsToSpring(payload)
      await this.$router.push({
        name: 'QnA-List-View'
      })
    }
  }
}
</script>

<style scoped>

</style>