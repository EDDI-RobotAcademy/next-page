<template>
  <v-row class="margin">
    <v-col>
      <div class="main_box">
        <div class="sub_box">
          <div class="title">정렬</div>
          <v-chip-group mandatory active-class="blue--text">
          <v-chip
            v-for="(sortNovel,index) in sortNovels" :key="index" @click="click()">
            {{ sortNovel.value }}
          </v-chip> 
        </v-chip-group>
        </div>
        <v-divider></v-divider>
        <div class="sub_box">
          <div class="title">장르</div>
          <v-chip-group mandatory active-class="blue--text">
          <v-chip v-for="(category,index) in categorys" :key="index" @click="click()">
            {{ category.value }}
          </v-chip>
        </v-chip-group>
        </div>
        <v-divider></v-divider>
        <div class="sub_box">
          <div class="title">초성</div>
          <v-chip-group mandatory active-class="blue--text">
          <v-chip v-for="(initial,index) in novelInitial" :key="index" @click="click()">
            {{ initial.value }}
          </v-chip>
        </v-chip-group>
        </div>
      </div>
    </v-col>
  </v-row>
</template>

<script>
export default {
  name: "BasicComponent",
  data() {
    return {

      chooseSort: "전체",
      

      sortNovels: [
        { value: '전체'},
        { value: '조회순'},
        { value: '추천순'},
        { value: '댓글순'},
      ],
      categorys: [
        { value: '전체'},
        { value: '로맨스'},
        { value: '무협'},
        { value: '추리'},
        { value: '판타지'},
        { value: '현대'},
        { value: '호러'},
        { value: '등등'},
        // 장르 추가
      ],
      novelInitial: [
        { value: '전체'},
        { value: 'ㄱ'},
        { value: 'ㄴ'},
        { value: 'ㄷ'},
        { value: 'ㄹ'},
        { value: 'ㅁ'}, 
        { value: 'ㅂ'},
        { value: 'ㅅ'},
        { value: 'ㅇ'},
        { value: 'ㅈ'},
        { value: 'ㅊ'},
        { value: 'ㅋ'},
        { value: 'ㅌ'},
        { value: 'ㅍ'},
        { value: 'ㅎ'},
      ]
    }
  },
  methods: {

  }
}
</script>

<style scoped>

.margin {
  margin-left: 150px;
  margin-right: 150px;
  margin-top: 10px;
  margin-bottom: 10px;
}

.main_box {
  border: 1px solid lightgrey;
}

.sub_box {
  display: flex;
}

.title {
  border-right: 1px solid lightgrey;
  color: white;
  font-weight: 500;
  margin: 0 10px 0 0;
  text-align: center;
  padding-top: 6px;
  font-size: 15px;
  width: 20%;
  padding-top: 12px;
  font-weight: bold;
  background: #6699FF;
}
</style>