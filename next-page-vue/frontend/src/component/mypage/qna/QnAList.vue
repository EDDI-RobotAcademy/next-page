<template>
  <div>
   <HeadlineMenuForm/>

<br><br><br><br>
    <div id='btn'>
      <v-btn class='white--text' id='btnRegisterPage'
             :to="{ name: 'QnA-Register-View' }">QnA 등록
      </v-btn>
    </div>
    <v-container>

      <div class="text">
        QnA
      </div>
      <br>
      <hr color="#6699FF" width="100%">

      <table>
        <tr>

            <th align="center" width="100" height="50" style="color: #6699FF" >No</th>
            <th align="center" width="180" height="50" style="color: #6699FF">카테고리</th>
            <th align="center" width="640" height="50" style="color: #6699FF">제목</th>
            <th align="center" width="240" height="50" style="color: #6699FF">등록일자</th>
        </tr>

        <tr v-if="!qnas || (Array.isArray(qnas) && qnas.length === 0)">
          <td colspan="4">
            현재 등록된 QnA가 없습니다.

          </td>
        </tr>
        <tr v-else v-for="qna in qnas" :key="qna.qnaNo">
          <td align="center">
            {{ qna.qnaNo }}
          </td>
          <td align="center">
            <router-link :to="{ name: 'QnA-Read-View',
                              params: { qnaNo: qna.qnaNo.toString() }}">

              {{ qna.category }}
            </router-link>
          </td>
          <td align="center">

            {{ qna.title }}
          </td>
          <td align="center">
            {{ qna.regDate }}
          </td>



        </tr>

      </table>
      <br><br><br>

      <br><br><br><br><br><br><br><br><br><br><br><br>

      <ul>

        <li><a href="#">1</a></li>
        <li><a href="#">2</a></li>
        <li><a href="#">3</a></li>
        <li><a href="#">4</a></li>
        <li><a href="#">5</a></li>

      </ul>




    </v-container>
  </div>

</template>

<script>


import HeadlineMenuForm from "@/component/header/HeadlineMenuForm";
export default {
  name: "QnAList",
  components: {HeadlineMenuForm },
  props: {
    qnas: {
      type: Array
    }
  },


  data() {
    return {


      page: 1,
      pageCount: 0,

    }
  }

}


</script>

<style scoped>

table{

  border-collapse: separate;
  border-spacing: 0 25px;

}

#btnRegisterPage {
  background: #6699FF;
}

#btn {
  text-align: right;
  margin-right: 10%;

}

.text {
  text-align: center;
  color: #6699FF;
  font-size: 60px;

}


a {
  text-decoration: none;
}

a:link {
  color : black;
}
a:visited {
  color : black;
}
a:hover {
  color : #6699FF;
}
a:active {
  color : red;
}

th{
  font-size: 20px;
}

ul {
  text-align:center;
}
ul li {
  display:inline;
  vertical-align:middle;
}
ul li a {
	/*FF2*/
  display:inline-block;
  vertical-align:top;
  padding:15px;
  margin-right:15px;
  width:15px !important;
  color:#6699FF;

  border:1px solid #fff;
  text-align:center;
  text-decoration:none;
  width /**/:26px;	/*IE 5.5*/

}
ul li a:hover, ul li a:focus {
  color:#fff;
  border:1px solid  #6699FF;
  background-color: #6699FF;
}


</style>