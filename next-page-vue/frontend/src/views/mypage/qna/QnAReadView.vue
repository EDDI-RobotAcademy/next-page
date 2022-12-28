<template>
  <div align="center">

    <QnARead v-if="qna" :qna="qna"/>

    <div id='btn'>

      <v-btn color="#6699FF" @click="onModify" style="font-size: 25px; color: white; width:180px;height:  50px">
        수정
      </v-btn> &nbsp; &nbsp; &nbsp;

      <v-btn color="#6699FF" @click="onDelete" style="font-size: 25px; color: white; width:180px;height:  50px">
        삭제
      </v-btn>

    </div>
    <br><br><br><br><br>
    <footer-menu-form/>

  </div>


</template>

<script>
import {mapActions, mapState} from "vuex";
import QnARead from "@/component/mypage/qna/QnARead";
import FooterMenuForm from "@/component/footer/FooterMenuForm";

export default {
  name: "QnAReadView",
  components: {FooterMenuForm, QnARead},
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

    onModify() {
      this.$router.push({
        name: "QnA-Modify-View",
        params: {qnaNo: this.qna.qnaNo}
      })
    },

    async onDelete() {
      await this.requestDeleteBoardToSpring(this.qnaNo);
      await this.$router.push({name: 'QnA-List-View'})
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

#btn {
  text-align: center;
  color: #6699FF;

}

</style>