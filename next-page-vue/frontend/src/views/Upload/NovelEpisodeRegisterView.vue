<template>
  <v-container>
    <novel-episode-register-form/>
  </v-container>
</template>

<script>
import NovelEpisodeRegisterForm from "@/component/Upload/NovelEpisodeRegisterForm";
export default {
  name: "NovelEpisodeRegisterView",
  components: {NovelEpisodeRegisterForm},
  props: {
    novelInfoNo: {
      type: Number,
      require: true,
    }
  },
}
</script>

<style scoped>

</style>