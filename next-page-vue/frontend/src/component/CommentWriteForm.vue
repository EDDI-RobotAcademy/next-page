<template>
  <div align="center">
    <v-container style="width: 1700px">
      <div>
        <form @submit="onSubmitRegister()">
          <div style="display: flex">
                  <v-textarea
                    v-model="comment"
                    placeholder="댓글을 입력해주세요."
                    auto-grow
                    outlined
                    color="#6699FF"
                    class="ml-10 mt-10"/>
                  &nbsp;&nbsp;
                  <v-btn
                    color="#6699FF"
                    width="128" 
                    height="128" 
                    class="mr-10 mt-10"
                    type="submit">
                    등록
                  </v-btn>
          </div>
        </form>
        <!-- 테스트 -->
        <comment-list-form/>
      </div>
    </v-container>
  </div>
</template>


<script>

import CommentListForm from '../component/CommentListForm.vue'

export default {
  name: "CommentWriteForm",
  components: {
    CommentListForm
  },
  data() {
    return {
      comment: '',
      commentWriter: '접속한 이메일'
    }
  },
  methods: {
    // 등록 메서드
    onSubmitRegister() {
      if (this.comment != '') {
        const { comment, commentWriter } = this
        this.$emit('submit', { comment, commentWriter })
      } else {
        alert("댓글을 입력해 주세요.")
      }
    },

  }
}
</script>

<style scoped>

</style>