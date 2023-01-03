<template>
  <!-- <div> -->
    <!-- test용 링크 -->
    <!-- <router-link to="/comment">댓글 TEST</router-link> |
  </div> -->
  <div>
    <!-- 헤더메뉴 -->
    <div id="hearder">
      <HeadlineMenuForm/>
      <MainMenuForm/>
    </div>
    
    <!-- 메인페이지 컴포넌트 -->
    <div id="main">
      <CarouselsNovel/>
      <SortNovel/>
    </div>
    
    <br><br><br><br><br>
    <!-- 풋터는 맨 아래 고정 -->
    <div id="footer">
      <FooterMenuForm/>
    </div>
  </div>
</template>

<script>

import CarouselsNovel from '@/component/CarouselsNovel.vue';
import FooterMenuForm from '@/component/footer/FooterMenuForm.vue';
import HeadlineMenuForm from '@/component/header/HeadlineMenuForm.vue';
import MainMenuForm from '@/component/header/MainMenuForm.vue';
import SortNovel from '@/component/sortNovel/SortNovel.vue';



export default {
  name: "HomeView",

  components: {
    HeadlineMenuForm,
    MainMenuForm,
    FooterMenuForm,
    CarouselsNovel,
    SortNovel
  },
};
</script>

<style scoped>

</style>
