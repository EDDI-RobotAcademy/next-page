<template>
  <div align="center">

    <QnAModify v-if="qna" :qna="qna" @submit="onSubmit"/>


  </div>
</template>

<script>
import {mapActions, mapState} from "vuex";
import QnAModify from "@/component/mypage/qna/QnAModify";
export default {
  name: "QnAModifyView",
  components: {QnAModify},
  props: {
    qnaNo: {
      type: String,
      required: true,
    }
  },
  computed: {
    ...mapState(['qna'])
  },
  methods: {
    ...mapActions([
      'requestBoardFromSpring',
      'requestBoardModifyToSpring'
    ]),
    async onSubmit (payload) {
      const { title, content, category, regDate } = payload
      const qnaNo = this.qnaNo
      await this.requestBoardModifyToSpring({ qnaNo, title, content, category, regDate })
      await this.$router.push({
        name: 'QnA-Read-View',
        params: { qnaNo: this.qnaNo }
      })
    }
  },
  created () {
    this.requestBoardFromSpring(this.qnaNo)
  }

}
</script>

<style scoped>

</style>