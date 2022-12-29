<template>
  <v-card class="pa-5">
    <v-row>
      <v-col>
        <div class="mt-5 mb-5 ml-3">
          <v-img v-show="this.file.length == 0" max-width="200px" :src="require(`@/assets/coverImages/${novelInfo.coverImage.reName}`)"/>
          <v-img v-for="(image, idx) in this.coverImagePreview" :key="idx" :src="image.url"
                 max-width="200px" contain style="margin-left: auto; margin-right: auto; display: block;" />
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
    <v-btn color="#6699FF" @click="submitNovelInfoModify">
      등록
    </v-btn>
  </v-card>
</template>

<script>
import axios from "axios";

export default {
  name: "NovelInformationModifyForm",
  props: {
    novelInfo: {
      type: Object,
    }
  },
  data() {
    return {
      file: '',
      coverImagePreview: '',
      title: '',
      category: '',
      introduction: [],
      publisher: '',
      author: '',
      categoryList: ["판타지", "무협", "로맨스", "현대"],
      openToPublic: false,
      purchasePoint: 0,
    }
  },

  mounted() {
    this.title = this.novelInfo.title
    this.category = this.novelInfo.category
    this.introduction = this.novelInfo.introduction.replace(/<br\s*\/?>/gi, '\r\n') // 엔터를 <br>로 저장했던 텍스트의 html 코드를 다시 /n으로 변환
    this.publisher = this.novelInfo.publisher
    this.author = this.novelInfo.author
    this.openToPublic = this.novelInfo.openToPublic
    this.purchasePoint = this.novelInfo.purchasePoint
  },

  methods: {
    uploadCoverImage() {
      this.coverImagePreview = []
      this.file = this.$refs.files.files

      if(!this.file.length == 0){
        for (let idx = 0; idx < this.file.length; idx++) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.coverImagePreview.push({url: e.target.result})
          }
          reader.readAsDataURL(this.file[idx])
        }
      }
    }, //uploadCoverImage

    submitNovelInfoModify() {

      let novelInfo = {
        title: this.title,
        category: this.category,
        introduction: this.introduction.replaceAll(/(\n|\r\n)/g,'<br>'), // /n을 <br>로 대체하여 저장
        publisher: this.publisher,
        author: this.author,
        openToPublic: this.openToPublic,
        purchasePoint: this.purchasePoint,
      }

      let novel_info_id = this.novelInfo.id

      if(this.file.length == 0) {

        console.log("파일 없이 수정")

        axios.post(`http://localhost:7777/novel/information-modify-text/${novel_info_id}`, novelInfo)
            .then (res => {
              if(res.data) {
                alert("수정 완료되었습니다!")
                this.$router.push('/information-list')
              }
            })
            .catch(res => {
              alert('오류: ' + res.message)
            })
      }

      else {

        let formData = new FormData()

        for (let idx = 0; idx < this.file.length; idx++) {
          console.log("파일리스트:"+idx)
          formData.append('fileList', this.file[idx])
        }

        formData.append(
            "info",
            new Blob([JSON.stringify(novelInfo)], { type: "application/json" })
        )

        axios.post(`http://localhost:7777/novel/information-modify-with-file/${novel_info_id}`, formData)
            .then (res => {
              if(res.data) {
                alert("등록 완료되었습니다!")
                this.$router.push('/information-list')
              }
            })
            .catch(res => {
              alert('오류: ' + res.message)
            })
      }

    } // submitNovelInfo

  }
}
</script>

<style scoped>

</style>