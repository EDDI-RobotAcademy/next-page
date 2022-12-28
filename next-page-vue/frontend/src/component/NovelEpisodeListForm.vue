<template>
  <v-container>
    <div>
      <table style="height: min-content" class="greentop">

        <tr>
          <th align="center" width="90">No</th>
          <th align="center" width="700">제목</th>
          <th align="center" width="130">유/무료</th>
          <th align="center" width="130">날짜</th>
        </tr>

        <tr v-if="!episodeList || (Array.isArray(episodeList) && episodeList.length === 0)">
          <td align="center" colspan="12">
            등록된 에피소드가 없습니다!
          </td>
        </tr>

        <tr v-else v-for="episode in episodeList" :key="episode.id">
          <td align="center">
            {{ episode.episodeNumber }}
          </td>

          <td align="left">
<!--            <router-link class="a" :to="{ name: 'BoardReadView',
                                params: { boardNo : board.boardNo.toString() }}">-->
          {{ episode.episodeTitle }}  &nbsp; - {{ episode.episodeNumber }} 화 -
            <!--            </router-link>-->
          </td>

          <td align="center">
            <v-icon small v-if="episode.needToBuy == true">
              mdi-currency-krw
            </v-icon>
          </td>

          <td align="center">
            {{ episode.uploadedDate }}
          </td>
        </tr>

      </table>
    </div>
  </v-container>
</template>

<script>
export default {
  name: "NovelEpisodeListForm",
  props: {
    episodeList: {
      type: Array,
    },
  },
  toRegister: {

  }
}
</script>

<style scoped>


.greentop {
  border-collapse: collapse;
  border-top: 3px solid #6699FF;
  font-size: small;
}
.greentop th {
  color: #6699FF;
  background: #eef1fc;
}
.greentop th, .greentop td {
  padding: 10px;
  border: 1px solid #ddd;
}
.greentop th:first-child, .greentop td:first-child {
  border-left: 0;
}
.greentop th:last-child, .greentop td:last-child {
  border-right: 0;
}
.greentop tr:hover td{
  color: #23463b
}


a:link {
  color : #000000;
  text-decoration: none;
}
a:visited {
  color : #53a48e;
  text-decoration: none;
}
a:hover {
  color : #356859;
  text-decoration: underline;
  font-weight: bold;
}
a:active {
  color : #356859;
  text-decoration: none;
}


</style>