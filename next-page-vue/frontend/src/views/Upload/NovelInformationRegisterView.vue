<template>
<div>
<HeadlineMenuForm/>
  <br><br><br><br>

  <novel-information-register-form/>

  <br><br><br><br><br>

  <FooterMenuForm/>

</div>



</template>

<script>
import NovelInformationRegisterForm from "@/component/Upload/NovelInformationRegisterForm";
import HeadlineMenuForm from "@/component/header/HeadlineMenuForm";
import FooterMenuForm from "@/component/footer/FooterMenuForm";
export default {
  name: "NovelInformationRegisterView",
  components: {FooterMenuForm, HeadlineMenuForm, NovelInformationRegisterForm},
}
</script>

<style scoped>

</style>