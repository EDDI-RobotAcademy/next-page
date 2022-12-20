<template>
  <v-card class="pa-5">
    <v-row>
      <v-col>
        <div class="mt-5 mb-5 ml-3">
          <v-img :src="this.coverImagePreview"/>
          <label>Files
            <input type="file" id="files" ref="files" accept="image/*"
                   v-on:change="uploadCoverImage"/>
          </label>
        </div>
      </v-col>
      <v-col>
        <v-text-field v-model="title" label="제목"/>
        <v-textarea v-model="introduction" label="소개글"/>
      </v-col>
      <v-col>
        <v-text-field v-model="author" label="작가"/>
        <v-text-field v-model="publisher" label="출판사"/>
        <v-text-field v-model="purchasePoint" label="결제 포인트"/>
        <v-switch v-model="openToPublic" label="공개"/>
        <v-select v-model="category" label="카테고리" :items="categoryList"/>
      </v-col>
    </v-row>
    <v-btn color="#6699FF" @click="submitNovelInfo">
      등록
    </v-btn>
  </v-card>
</template>

<script>

import axios from 'axios'

export default {
  name: "NovelInformationRegisterForm",
  data() {
    return {
      file: '',
      coverImagePreview: '',
      title: '',
      category: '',
      introduction: '',
      publisher: '',
      author: '',
      categoryList: ["판타지", "무협", "로맨스", "현대"],
      openToPublic: false,
      purchasePoint: 0,
    }
  },
  methods: {
    uploadCoverImage() {
      this.file = this.$refs.files.files

      if(!this.file.length == 0) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.coverImagePreview = e.target.result
        }
        reader.readAsDataURL(this.file)
      }
    },

    submitNovelInfo() {
      let formData = new FormData()

      let novelInfo = {
        member_id: 1,
        title: this.title,
        category: this.category,
        introduction: this.introduction,
        publisher: this.publisher,
        author: this.author,
        openToPublic: this.openToPublic,
        purchasePoint: this.purchasePoint,
      }

      formData.append('fileList', this.file)

      formData.append(
          "novelInfo",
          new Blob([JSON.stringify(novelInfo)], { type: "application/json" })
      )

      axios.post('http://localhost:7777/novel/information-register', formData)
          .then (res => {
            alert('처리 결과: ' + res.data)
          })
          .catch(res => {
            alert('처리 결과:' + res.message)
          })
    }

  }
}
</script>

<style scoped>

</style>