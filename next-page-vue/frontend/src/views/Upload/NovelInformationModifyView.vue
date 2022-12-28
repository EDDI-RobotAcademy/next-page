<template>
  <novel-information-modify-form :novel-info="this.$store.state.novelInfoDetail"/>
</template>

<script>
import NovelInformationModifyForm from "@/component/Upload/NovelInformationModifyForm";
export default {
  name: "NovelInformationModifyView",
  components: {NovelInformationModifyForm},
  props: {
    NovelInfoNo: Number,
  }
}
</script>

<style scoped>

</style>