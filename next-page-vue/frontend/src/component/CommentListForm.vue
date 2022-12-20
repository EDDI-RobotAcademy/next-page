<template>
  <v-container style="width: 1100px">
    <div class="title">
      <b>댓글</b>
      <span class="ml-5" v-if="comments">
        {{ comments.length }}
      </span>
    </div>
    <div>
      <v-model v-if="!comments || (Array.isArray(comments) && comments.length === 0)">
      등록된 댓글이 없습니다.
      </v-model>
    </div>
  </v-container>
</template>
  
<script>
export default {
  name: "CommentListForm",
    data() {
      return {
       
      }
  }
}
</script>
  
<style scoped>

.title {
  font-size: 24px;
  display: block;
  color: #000;
  padding: 30px 35px 30px 12px;
  text-align: left;
}

</style>