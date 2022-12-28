<template>
  <v-container>
    <novel-information-detail-for-uploader-form/>
    <novel-episode-list-form :episode-list="this.$store.state.novelEpisodeList.content"/>
  </v-container>
</template>

<script>
import NovelInformationDetailForUploaderForm from "@/component/Upload/NovelInformationDetailForUploaderForm";
import axios from "axios";
import {mapActions} from "vuex";
import NovelEpisodeListForm from "@/component/NovelEpisodeListForm";
export default {
  name: "NovelInformationDetailView",
  components: {NovelEpisodeListForm, NovelInformationDetailForUploaderForm},
  props: {
    novelInfoNo: {
      type: Number,
      require: true,
    }
  },
  data() {
    return {
      novelInfo: {},
    }
  },
  methods: {
    ...mapActions(['requestEpisodeListToSpring']),

    async getNovelInfoDetail() {
      console.log("getNovelInfoDetail")
      let novel_info_id = this.novelInfoNo
      await axios.get(`http://localhost:7777/novel/information-detail/${novel_info_id}`)
          .then((res) => {
            console.log(res.data)
            this.$store.state.novelInfoDetail = res.data
          })
          .catch((error) => {
            alert(error.message)
          })
    },

    async getNovelEpisodeList() {
      console.log("getNovelEpisodeList")
      const payload = {
        novel_info_id : this.novelInfoNo,
        page: 0,
        size: 1
      }
      await this.requestEpisodeListToSpring(payload)
    },

  },

   created() {
     this.getNovelInfoDetail()
     this.getNovelEpisodeList()
  }
}

</script>

<style scoped>

</style>