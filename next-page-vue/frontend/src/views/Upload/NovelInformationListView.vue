<template>
  <v-container>
    <v-row>
      <v-col v-for="info in this.$store.state.uploaderNovelInfoList.content" :key="info.id">
        <content-simple-ui :novel-info="info"/>
      </v-col>
    </v-row>
    <v-pagination
        v-model="page"
        :length="this.$store.state.uploaderNovelInfoList.totalPages"/>
    <v-btn @click="toRegisterNovelInfo"> 소설 정보 등록 </v-btn>
  </v-container>
</template>

<script>
import {mapActions} from "vuex";
import ContentSimpleUi from "@/component/Upload/ContentSimpleUi";

export default {
  name: "NovelInformationListView",
  components: {ContentSimpleUi},
  data() {
    return {
      page: 1,
    }
  },
  methods: {
    ...mapActions(['requestUploaderNovelInfoListToSpring']),
    toRegisterNovelInfo() {
      this.$router.push('/information-register')
    }
  },
  mounted() {
    let payload = {
      member_id: 1,
      page: this.page-1,
      size: 5
    }
    this.requestUploaderNovelInfoListToSpring( payload )
  }
}
</script>

<style scoped>

</style>