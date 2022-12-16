<template>
  <v-container>
    <novel-information-register-form/>
  </v-container>
</template>

<script>
import NovelInformationRegisterForm from "@/component/Upload/NovelInformationRegisterForm";
export default {
  name: "NovelInformationRegisterView",
  components: {NovelInformationRegisterForm},
}
</script>

<style scoped>

</style>