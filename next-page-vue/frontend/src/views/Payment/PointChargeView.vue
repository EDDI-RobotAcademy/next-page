<template>
  <div>


    <headline-menu-form/>

    <br><br><br><br>
    <PointChargeForm/>



    <br><br><br><br><br><br><br>
  <footer-menu-form/>
  </div>
</template>

<script>
import PointChargeForm from "@/component/PointCharge/PointChargeForm";
import HeadlineMenuForm from "@/component/header/HeadlineMenuForm";
import FooterMenuForm from "@/component/footer/FooterMenuForm";

export default {
  name: "PointChargeView",
  components: {FooterMenuForm, HeadlineMenuForm,  PointChargeForm}
}
</script>

<style scoped>

</style>