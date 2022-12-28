<template>
  <v-container>
    <v-card>
      <div class="d-flex">
        <v-img max-height="300px" max-width="200px" :src="require(`@/assets/coverImages/${this.novelInfoDetail.coverImage.reName}`)"/>
        <v-card-text>
          <h2> {{ this.novelInfoDetail.title }}</h2>
          {{ this.novelInfoDetail.author }}
          <p>출판사: {{ this.novelInfoDetail.publisher }} </p>

          구매 가격: {{ this.novelInfoDetail.purchasePoint }}

          <p>소개글</p>

          <div v-html="this.novelInfoDetail.introduction"></div>

          공개여부 <v-switch disabled :input-value="this.novelInfoDetail.openToPublic"/>
        </v-card-text>
        <v-btn class="mb-2" @click="toInformationModify">정보 수정</v-btn>
        <v-btn class="mb-2" @click="toEpisodeRegister">새 에피소드 등록</v-btn>
      </div>
    </v-card>
  </v-container>
</template>

<script>

import {mapState} from "vuex";

export default {
  name: "NovelInformationDetailForUploaderForm",
  computed: {
    ...mapState(['novelInfoDetail'])
  },
  methods: {
    toEpisodeRegister() {
      this.$router.push( {
        name: "EpisodeRegister",
        params: { novelInfoNo : this.novelInfoDetail.id }
      })
    },
    toInformationModify() {
      this.$router.push( {
        name: "InformationModify",
        params: { novelInfoNo : this.novelInfoDetail.id }
      })
    }
  }
}
</script>

<style scoped>

</style>