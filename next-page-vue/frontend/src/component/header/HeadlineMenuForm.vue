<template>
  <div class="header">
    <div class="header_menu">
      <v-toolbar flat style="font-family: 'Noto Sans KR', sans-serif" height="40">
        <router-link to="/">
          <v-btn color="#black" text plain :ripple="false">
            웹툰/만화
          </v-btn>
        </router-link>&nbsp;
        <router-link to="/">
          <v-btn color="black" text plain :ripple="false">
            웹소설
          </v-btn>
        </router-link>&nbsp;
        <router-link to="/">
          <v-btn color="black" text plain :ripple="false">
            도서
          </v-btn>
        </router-link>
        <!-- 여기까지는 로그인 유무와 상관없이 보이는 메뉴들 -->
    
        
        <v-spacer></v-spacer>
        <!-- 비로그인 상태에서 보이는 회원메뉴 UI -->
        <div v-if="($store.state.isAuthenticated == false)">
          <router-link to="/member-join-form">
            <v-btn color="black" text plain :ripple="false">
              회원가입
            </v-btn>
          </router-link>&nbsp;
          <router-link to="/signin-view">
            <v-btn color="black" text plain :ripple="false">  
              로그인
            </v-btn>
          </router-link>
        </div>

        <!-- 로그인 상태에서 보이는 회원메뉴 UI -->
        <div v-else>
          <router-link to="/point">
            <v-btn color="black" text plain :ripple="false">
              포인트 충전
            </v-btn>
          </router-link>&nbsp;
          <router-link to="/">
            <v-btn color="black" text plain :ripple="false">
              구입내역
            </v-btn>
          </router-link>
          <router-link to="/">
            <v-btn color="black" text plain :ripple="false">
              마이페이지?
            </v-btn>
          </router-link>&nbsp;
          <v-dialog v-model="logoutDialog" persisten max-width="400">
            <template v-slot:activator="{on}">
              <v-btn color="black" text plain :ripple="false" v-on="on">
                로그아웃
              </v-btn>
            </template>
            <v-card>
              <v-card-title>
                {{ logoutTitle }}
              </v-card-title>
              <v-card-text>
                {{ logoutMessage }}
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="grey darken-2" text plain @click="cancelBtn" :ripple="false">
                  취소
                </v-btn>
                <v-btn color="red" text plain @click="logoutBtn" :ripple="false">
                  로그아웃
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </div>
      </v-toolbar>
    </div>
    <div class="header_line">
    </div>
  </div>
</template>
  
<script>

export default {
  name: "HeadlineMenuForm",  /* 컴포넌트 이름 선정 어떻게 구분...? */
  data() {
      return {
        logoutTitle: "로그아웃",
        logoutMessage: "로그아웃을 하시겠습니까?",
        logoutDialog: false,

        ripple: false,
      };
  },
  methods: {
    cancelBtn() {
      this.logoutDialog = false
    },
    logoutBtn() {

    }
  },
}
</script>
  
<style scoped>

@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');

a {
  text-decoration: none;
}

.header {
  position: relative;
  margin-left: 0px;
  margin-right: 0px;
}
.header_menu {
  margin-left: 120px;
  margin-right: 120px;
  background: none;
}

.header_line {
  border-bottom: 1px solid #f0f0f0;
}

</style>