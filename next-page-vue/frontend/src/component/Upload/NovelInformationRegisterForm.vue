<template>
  <div>
    <div style="color: #6699FF; font-size: 40px; text-align: center">
      소설 업로드
    </div>
    <br><br>

    <table>
      <tr>
        <th align="center" width="850" height="50" style="color: #6699FF">
          <div class="mt-5 mb-5 ml-3">
            <v-img v-for="(image, idx) in this.coverImagePreview" :key="idx" :src="image.url"
                   max-width="200px" contain style="margin-left: auto; margin-right: auto; display: block;"/>
            <label>Files
              <input type="file" id="files" ref="files" accept="image/*"
                     v-on:change="uploadCoverImage"/>
            </label>
          </div>
        </th>
      </tr>
      <tr>
        <th align="center" width="" height="50" style="color: #6699FF">
          <v-text-field v-model="title" label="제목"/>
        </th>
      </tr>
      <tr>
        <th align="center" width="" height="50" style="color: #6699FF">
          <v-textarea v-model="introduction" label="소개글"/>
        </th>
      </tr>
      <tr>
        <th align="center" width="" height="50" style="color: #6699FF">
          <v-text-field v-model="author" label="작가"/>
        </th>
      </tr>
      <tr>
        <th align="center" width="" height="50" style="color: #6699FF">
          <v-text-field v-model="publisher" label="출판사"/>
        </th>
      </tr>
      <tr>
        <th align="center" width="" height="50" style="color: #6699FF">
          <v-text-field v-model="purchasePoint" label="결제 포인트"/>
        </th>
      </tr>
      <tr>
        <th align="center" width="" height="50" style="color: #6699FF">
          <v-switch v-model="openToPublic" label="공개"/>
        </th>
      </tr>
      <tr>
        <th align="center" width="" height="50" style="color: #6699FF">
          <v-select v-model="category" label="카테고리" :items="categoryList"/>
        </th>
      </tr>
      <br><br>
<div id ='btn'>
      <v-btn color="#6699FF" style="font-size: 30px; width: 150px; height: 50px; color: white;" @click="submitNovelInfo">
        등록
      </v-btn>
</div>

    </table>
  </div>
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
      introduction: [],
      publisher: '',
      author: '',
      categoryList: ["판타지", "무협", "로맨스", "현대판타지","BL"],
      openToPublic: false,
      purchasePoint: 0,
    }
  },
  methods: {
    uploadCoverImage() {
      this.coverImagePreview = []
      this.file = this.$refs.files.files

      if (!this.file.length == 0) {
        for (let idx = 0; idx < this.file.length; idx++) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.coverImagePreview.push({url: e.target.result})
          }
          reader.readAsDataURL(this.file[idx])
        }
      }
    },

    submitNovelInfo() {
      let formData = new FormData()

      let novelInfo = {
        member_id: 1,
        title: this.title,
        category: this.category,
        introduction: this.introduction.replaceAll(/(\n|\r\n)/g, '<br>'), // /n을 <br>로 대체하여 저장
        publisher: this.publisher,
        author: this.author,
        openToPublic: this.openToPublic,
        purchasePoint: this.purchasePoint,
      }

      for (let idx = 0; idx < this.file.length; idx++) {
        console.log("파일리스트 반복문:" + idx)
        formData.append('fileList', this.file[idx])
      }

      formData.append(
          "info",
          new Blob([JSON.stringify(novelInfo)], {type: "application/json"})
      )

      axios.post('http://localhost:7777/novel/information-register', formData)
          .then(res => {
            if (res.data) {
              alert("등록 완료되었습니다!")
              this.$router.push('/home')
            }
          })
          .catch(res => {
            alert('오류: ' + res.message)
          })
    }

  }
}
</script>

<style scoped>


table {

  border-collapse: separate;
  border-spacing: 0 25px;
  margin-left: 30%;
  margin-right: 30%;;

}

#btn {
  text-align: center;


}

</style>