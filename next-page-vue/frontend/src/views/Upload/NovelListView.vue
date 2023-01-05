<template>
  <div>
    <h1>소설리스트</h1>
      <br/>
      <div v-for="(item, index) in uploaderNovelLists" :key="index">
        <ContentSimpleUiTest :uploaderNovelLists="uploaderNovelLists"/>
      </div>
      
      <!-- <v-pagination
        v-model="page"
        :length="this.$store.state.uploaderNovelList.totalPages"/> -->
    <v-btn @click="toRegisterNovelInfo"> 소설 정보 등록 </v-btn>
  </div>
</template>

<script>
import {mapState, mapActions} from "vuex";
import ContentSimpleUiTest from "@/component/Upload/ContentSimpleUiTest";

export default {
  name: "NovelListView",
  components: {ContentSimpleUiTest},
  computed: {
    ...mapState([
      // 'uploaderNovelList'
      'uploaderNovelLists'
    ]),
  },
  data() {
    return {
      page: 1,
    }
  },
  methods: {
    ...mapActions(['requestNovelListToSpring']),
    toRegisterNovelInfo() {
      this.$router.push('/information-register')
    }
  },
  mounted() {
    this.requestNovelListToSpring()
  }
}
</script>

<style scoped>

</style>