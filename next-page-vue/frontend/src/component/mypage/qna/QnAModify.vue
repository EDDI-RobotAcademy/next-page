<template>
  <div>
    <HeadlineMenuForm/>

    <br><br><br><br>


    <form @submit.prevent="onSubmit">

      <div class="text">
        QnA

      </div>

      <div class="text2">
        <v-select v-model="category" label="카테고리" :items="categoryList" style="color: #6699FF"></v-select>

        <v-text-field v-model="title" label="제목" type="text"></v-text-field>
        <div id='a'>
          <li style="color:#6699FF">
            등록일: {{ qna.regDate }}
          </li>
        </div>

        <v-textarea v-model="content" label="본문" type="text" height="300px" style="color: #6699FF"></v-textarea>
      </div>

      <br><br>

      <div id='btn'>

        <v-btn class="white--text" id="BtnRegister" type="submit" style="font-size: 25px" >수정 </v-btn>

      </div>
      <br><br><br><br><br><br>
      <footer-menu-form/>

    </form>
  </div>
</template>

<script>


import HeadlineMenuForm from "@/component/header/HeadlineMenuForm";
import FooterMenuForm from "@/component/footer/FooterMenuForm";
export default {
  name: "QnAModify",
  components: {FooterMenuForm, HeadlineMenuForm},
  props: {
    qna: {
      type: Object,
      required: true,
    }
  },
  data() {
    return {
      title: '',
      category: '',
      content: '',
      regDate: '',
      categoryList: ['소설 문의', '서비스 문의', '환불/취소 문의', '기타'],
    }
  },
  created() {
    this.title = this.qna.title
    this.content = this.qna.content
    this.category = this.qna.category
    this.regDate = this.qna.regDate
  },
  methods: {
    onSubmit() {
      const {title, content, category, regDate} = this
      this.$emit('submit', {title, content, category, regDate})
    }
  }

}
</script>

<style scoped>

.text {
  color: #6699FF;
  font-size: 60px;
}

.text2 {

  margin-right: 20%;
  margin-left: 20%;
}


#a {
  text-align: right;
  font-size: 15px;
}


a {
  text-decoration: none;
}


#btn { text-align: center; font-size: 25px;  right:auto}

#BtnRegister { background-color: #6699FF; width: 180px; height: 50px;}

</style>