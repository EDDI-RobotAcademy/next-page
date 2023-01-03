<template>
  <div class=cn>
    <div class=carousel-wrap>
      <carousel v-bind="options" @initialized="init" @change="changed">
        <router-link to="/angel">
          <img class="img-size" src="@/assets/carousel/angel.png" />
        </router-link>
        <router-link to="/earth">
          <img class="img-size" src="@/assets/carousel/earth.png" />
        </router-link>
        <router-link to="/giant">
          <img class="img-size" src="@/assets/carousel/giant.png" />
        </router-link>
        <router-link to="/monalisa">
          <img class="img-size" src="@/assets/carousel/monalisa.png" />
        </router-link>
        <router-link to="/21gram">
          <img class="img-size" src="@/assets/carousel/21gram.png" />
        </router-link>
        <router-link to="/briefing">
          <img class="img-size" src="@/assets/carousel/briefing.png" />
        </router-link>
        <router-link to="/heisnot">
          <img class="img-size" src="@/assets/carousel/heisnot.png" />
        </router-link>
        <router-link to="/jingyo">
          <img class="img-size" src="@/assets/carousel/jingyo.png" />
        </router-link>
        <router-link to="/pokya">
          <img class="img-size" src="@/assets/carousel/pokya.png" />
        </router-link>
      </carousel>
    </div>
  </div>
</template>

<script>

import carousel from 'vue-owl-carousel2'

export default {
  name: "CarouselsNovel",
  components: { 
    carousel 
  },
  data() {
    return {
      plugin: null,
      options: {
        autoplay: true,  // 자동실행
        items: 2, // 보여지는 아이템 개수
        autopalyTimeout: 2000, // 넘어가는 시간 조절
        loop: true, // 반복 여부
        margin: 10, // margin
        mouseDrag: false, //
        pullDrag: false,  // 드래그
        touchDrag: false, //
        autoplayHoverPause: true, // mouseOver 시 실행x
        navText: ["<",">"] // nav 버튼 모양(이미지 파일 가능)
      }
    }
  },

}
</script>

<style scoped>
.cn {
  margin-left: 120px;
  margin-right: 120px;
}

.carousel-wrap {
  margin: 30px
}

.img-size {
  height: 300px;
  width: 600px;
}

</style>