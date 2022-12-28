<template>
  <router-link :to=" { name: 'InformationDetail',
                       params: { novelInfoNo : novelInfo.id }} ">
    <v-card max-width="200px" class="pa-2">
      <v-img height="250px" :src="require(`@/assets/coverImages/${novelInfo.coverImage.reName}`)"/>
      <v-card-text class="justify-center">
        {{ novelInfo.title}}
      </v-card-text>
      <v-card-text>
        <v-icon>
          mdi-account-edit
        </v-icon>
        {{ novelInfo.author }}
      </v-card-text>
    </v-card>
  </router-link>
</template>

<script>
export default {
  name: "ContentSimpleUi",
  props: {
    novelInfo : {
      type: Object,
    }
  }
}
</script>

<style scoped>

</style>