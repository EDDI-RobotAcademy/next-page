<template>
  <div align="center">

    <QnARead v-if="qna" :qna="qna"/>




    <v-icon style="color: #6699FF">mdi-cloud-upload</v-icon>
    <router-link :to="{ name: 'QnA-Modify-View', params: { qnaNo } }" style="font-size: 25px; color: #6699FF" >
      수정
    </router-link>

    <v-icon style="color: #6699FF">mdi-trash-can</v-icon>
    <button @click="onDelete" style="font-size: 25px; color: #6699FF">삭제</button>


</div>


</template>

<script>
import {mapActions, mapState} from "vuex";
import QnARead from "@/component/mypage/qna/QnARead";

export default {
  name: "QnAReadView",
  components: {QnARead},
  props: {
    qnaNo: {
      type: String,
      required: true
    }
  },
  computed: {
    ...mapState(['qna'])
  },
  methods: {
    ...mapActions([
      'requestBoardFromSpring',
      'requestDeleteBoardToSpring',
    ]),
    async onDelete () {
      await this.requestDeleteBoardToSpring(this.qnaNo);
      await this.$router.push({ name: 'QnA-List-View' })
    }
  },
  created() {
    this.requestBoardFromSpring(this.qnaNo)
  }
}
</script>

<style scoped>

a {
  text-decoration: none;
}



</style>