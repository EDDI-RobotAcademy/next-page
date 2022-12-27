<template>
<div>

  <HeadlineMenuForm/>

  <br><br><br><br>



  <form @submit.prevent="onSubmit">
    <div class="text">
      QnA


    </div>
    <br><br>

    <div class="text2">
    <v-text-field v-model="title" label="제목" type="text" ></v-text-field>
    <v-select v-model="category" label="카테고리" :items="categoryList" style="color: #6699FF"></v-select>
    <v-textarea v-model="content" label="본문" type="text" height="300px" style="color: #6699FF" ></v-textarea>

    </div>


    <br><br>

    <div id ='btn'>
      <v-btn class="white--text" id="BtnRegister" type="submit">등록</v-btn>

    </div>
  </form>

</div>
</template>

<script>

import HeadlineMenuForm from "@/component/header/HeadlineMenuForm";
export default {
  name: "QnARegister",
  components: {HeadlineMenuForm},
  data () {
    return {
      title: '',
      categoryList:['소설 문의', '서비스 문의', '환불/취소 문의', '기타'],
      content: '',
    }
  },
  methods: {
    onSubmit () {
      const { title, category, content } = this
      this.$emit('submit', { title, category, content })
    }
  }


}
</script>

<style scoped>


.text{

  color: #6699FF;
  font-size: 60px;

}


.text2{

  margin-right: 20%;
  margin-left: 20%;


}

#btn { text-align: center; font-size: 20px;  right:auto}

#BtnRegister { background-color: #6699FF; width: 180px; height: 50px;}


a {
  text-decoration: none;
}


</style>