<template>
  <div class="menu" style="margin-bottom: 30px">
    <div class="home_logo" style="font-family: 'Noto Sans Tangsa', sans-serif; float: left; margin-right: 100px; font-size: 50px">
      <router-link to="/" class="link_logo">   
        NEXT PAGE
      </router-link>
    </div>
    <div class="search">
      <v-text-field placeholder="검색어를 입력하세요"
                    onfocus="this.placeholder=''"
                    onblur="this.placeholder='검색어를 입력하세요.'"
                    append-icon="mdi-magnify">
      </v-text-field>
    </div>
  </div>

  
</template>

<script>
export default {
  name: "MainMenuForm",
  data() {
    return {

    }
  }
}
</script>

<style scoped>

@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+Tangsa:wght@700&display=swap');

a {
  text-decoration: none;
}

.menu {
  margin-left: 150px;
  margin-right: 150px;
  margin-top: 10px;
  margin-bottom: 10px;
}

.home_logo {
  font-size: 35px;
  
}

.link_logo {
  color: #6699FF;
}

.search {
  color: #6699FF;
  width: 900px;
}

</style>