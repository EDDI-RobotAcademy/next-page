<template>
  <v-container>
    <v-card>
      <v-card-text>
        <h5>포인트 충전이 완료되었습니다.</h5>
        메인으로 돌아갑니다.
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
export default {
  name: "PaymentSuccessView",

  mounted() {
    setTimeout(()=> { this.$router.push("/") }, 3000) // 3초후 자동으로 메인으로 돌아감
  }
}
</script>

<style scoped>

</style>