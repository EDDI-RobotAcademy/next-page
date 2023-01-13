<template>
  <div>

    <HeadlineMenuForm/>
    <br><br><br><br>

    <div class="text" style="margin-left: 200px; font-family: 'Noto Sans Tangsa', sans-serif;'">
      My Page

    </div>

    <br>
    <div class="nick">

      {{ this.userNickName }} 님

    </div>


    <br><br>
    <hr color="#6699FF" width="100%">

    <br><br>
    <div style="margin-left: 200px">
      <v-tabs vertical >
        <hr color="white" width="100%">
        <v-tab style="margin-bottom: 30px; width: 200px;  color: black; font-size: 17px; height: 80px ">
          MY 공지사항
        </v-tab>

        <v-tab-item>
          <MyPageNoticeForm/>


        </v-tab-item>


        <v-tab style="margin-bottom: 30px; width: 200px; color: black; font-size: 17px; height: 80px ">
          MY 정보보기
        </v-tab>


        <v-tab-item>
          <MyPageReadView/>
        </v-tab-item>


        <v-tab style="margin-bottom: 30px; width: 200px; color: black; font-size: 17px; height: 80px">
          MY 문의사항
        </v-tab>
        <v-tab-item>
          <QnAListView/>
        </v-tab-item>


        <v-tab style="margin-bottom: 30px; width: 200px; color: black; font-size: 17px; height: 80px">
          MY 회원탈퇴
        </v-tab>
        <v-tab-item>
          <MyPageOutForm/>
        </v-tab-item>


      </v-tabs>


    </div>

    <br><br><br><br><br><br><br><br><br><br>
    <footer-menu-form/>


  </div>
</template>

<script>
import HeadlineMenuForm from "@/component/header/HeadlineMenuForm";
import MyPageOutForm from "@/component/mypage/MyPageOutForm";
import MyPageNoticeForm from "@/component/mypage/MyPageNoticeForm";
import FooterMenuForm from "@/component/footer/FooterMenuForm";
import QnAListView from "@/views/mypage/qna/QnAListView";
import MyPageReadView from "@/views/mypage/MyPageReadView";



export default {
  name: "MyPageNavi",

  components: {
    MyPageReadView,

    QnAListView,
    FooterMenuForm,
    MyPageNoticeForm,
    MyPageOutForm,
    HeadlineMenuForm
  },


  data() {
    return {
      userNickName: this.$store.state.memberInfoAfterSignIn.userNickName,

    }
  },

  methods: {},

  async mounted() {
    this.userNickName = this.$store.state.memberInfoAfterSignIn.userNickName
  },

}


</script>

<style scoped>

@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+Tangsa:wght@700&display=swap');


.text {
  text-align: left;
  color: #6699FF;
  font-size:50px;

}

.nick{

  margin-left: 200px;
  font-size: 18px;



}

</style>