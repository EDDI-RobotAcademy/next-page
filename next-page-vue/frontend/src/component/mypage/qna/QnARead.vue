<template>
  <div>
    <HeadlineMenuForm/>
    <br><br><br>
    <div class="set">
      <div class="text">

        MY QnA

      </div>
      <v-input style="color:#6699FF">{{ qna.category }}</v-input>
      <v-input id="title" style="font-size: 26px">{{ qna.title }}</v-input>
      <hr color="#6699FF" width="100%">
      <br>
      <div id='a'>
        <li style="color:#6699FF">
          등록일: {{ qna.regDate }}
        </li>
        <br><br>
        <textarea cols="138" rows="20" :value="qna.content" type="text" readonly></textarea><br>

      </div>

    </div>
  </div>
</template>

<script>

import HeadlineMenuForm from "@/component/header/HeadlineMenuForm";

export default {
  name: "QnARead",
  components: {HeadlineMenuForm},
  props: {
    qna: {
      type: Object,
      required: true,
    }
  },

}
</script>

<style scoped>


.set {

  margin-right: 20%;
  margin-left: 20%;


}

.text {
  color: #6699FF;
  font-size: 60px;


}

#a {
  text-align: right;
  font-size: 15px;
}


textarea {
  width: 120%;
  padding: 10px;
  box-sizing: border-box;
  outline-style: none;
  border-radius: 5px;
}


</style>