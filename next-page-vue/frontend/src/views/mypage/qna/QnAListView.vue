<template>

  <div id="qna">
    <QnAList :qnas="qnas"/>
  </div>

</template>

<script>
import { mapState, mapActions } from "vuex";
import QnAList from "@/component/mypage/qna/QnAList";

export default {
  name: "QnAListView",
  components:{
    QnAList

  },

  computed: {
    ...mapState([
      'qnas'
    ]),
  },
  mounted() {
    this.requestBoardListFromSpring()
  },
  methods: {
    ...mapActions([
      'requestBoardListFromSpring'
    ])
  }

}
</script>

<style scoped>

</style>