<template>
  <footer>
    <v-container fluid class="footBtm">
      <v-col class="footInner">
        <ul class="footMenu">
          <li><a href="/Member-Join-Form" role="button">개인정보처리방침</a></li>
          <li><a href="/Member-Join-Form" role="button">이용약관</a></li>
        </ul>
        <p class="txtFoot">
          <span>(주)NEXT-PAGE 대표이사 : 000 </span>
          <span>사업자등록번호 : 100-10-10000</span>
          <span>
					통신판매신고 제2023
				</span>
          <span>관광사업자 등록번호 : 제2023-01호</span>
        </p>
        <p class="txtFoot" style="margin:0">
          <span>서울특별시 강남구 강남구 테헤란로14길 6</span>
        </p>
        <p class="txtFoot02">
          (주)NEXT-PAGE 는 소설, 웹툰 등 다양한 컨텐츠를 구입하고 감상할수 있는 서비스로 창작물의 저작권은 해당 출판사에 있습니다.
          <br>
          (주)NEXT-PAGE 에 있는 모든 저작물은  NEXT-PAGE 파트너사가 제공하는 일부 출판사에 대하여 통신판매중개자의 지위를 가지며, 해당 상품, 상품정보, 거래에 관한 의무와 책임은 판매자에게 있습니다.
        </p>
        <div style="text-align: center">
          <p class="txtCopy ">
            <span>Copyright NEXT-PAGE All Rights Reserved</span>
          </p>

        </div>
      </v-col>
    </v-container>
  </footer>
  
</template>

<script>

export default {
  name: "FooterMenuForm",
  data() {
    return {

    }
  }
}
</script>

<style scoped>


text{

  text-align: center;

}


p, ul, ol, li, button, div, footer, span {
  margin: 0;
  padding: 0;
  color: #606060;
  font-family: Pretendard,-apple-system,BlinkMacSystemFont,Open Sans,Helvetica Neue,sans-serif;
  font-weight: 400;
  font-size: 10px;
  line-height: 1.5;
  letter-spacing: -0.01em;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  word-break: keep-all;
  word-wrap: break-word;
  white-space: normal;
}
p {
  display: block;
  margin-block-start: 1em;
  margin-block-end: 1em;
  margin-inline-start: 0px;
  margin-inline-end: 0px;
}
footer {
  position: relative;
  height: 304px;
  border-top: 1px solid #EAEAEA;
  text-align: center;
  z-index: 1;
  background: #6699FF;
}
footer .footBtm .footInner {
  padding: 60px 72px 0 72px;
}
footer .footInner {
  position: relative;
  width: 1280px;
  margin: 0 auto;
  padding: 0 72px;
  text-align: left;
  z-index: 2;
}
footer .footBtm .footMenu {
  margin-left: -9px;
}
ul {
  list-style: none;
  display: block;
}
ul:after, ol:after {
  content: '';
  display: block;
  clear: both;
}
li {
  float: left;
  font-family: Pretendard,-apple-system,BlinkMacSystemFont,Open Sans,Helvetica Neue,sans-serif;
  margin: 0;
  padding: 0;
  color: #606060;
  font-weight: 400;
  font-size: 1.0rem;
}
a {
  color: inherit;
  text-decoration: none;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}
footer .footBtm .footMenu>li:first-child a {
  color: #fff;
  font-weight: 600;
}
footer .footBtm .footMenu>li>a {
  position: relative;
  padding: 0 8px 0 9px;
  color: rgba(255,255,255,0.6);
  line-height: 29px;
  font-weight: 400;
}
footer .footBtm .footMenu>li>a:before {
  content: '';
  display: block;
  position: absolute;
  top: 50%;
  left: 0;
  width: 1px;
  height: 14px;
  margin-top: -8px;
  background: rgba(255,255,255,0.5);
}
footer .footBtm .footMenu>li:first-child a:before {
  display: none;
}
footer .footBtm .txtFoot {
  margin-top: 19px;
  color: rgba(255,255,255,0.6);
}
footer .footBtm .txtFoot span {
  display: inline-block;
  position: relative;
  padding: 0 8px 0 9px;
  color: rgba(255,255,255,0.6);
  line-height: 1.3em;
  font-size: 0.8rem;
}
footer .footBtm .txtFoot span:first-child {
  padding-left: 0;
}
footer .footBtm .txtFoot span .btns {
  border: 1px solid rgba(255,255,255,0.5);
  padding: 5px;
  font-size: 1.1rem;
  border-radius: 5px;
  margin-left: 4px;
}
footer .footBtm .txtFoot span:first-child:before {
  display: none;
}
footer .footBtm .txtFoot span:before {
  content: '';
  display: block;
  position: absolute;
  top: 50%;
  left: 0;
  width: 1px;
  height: 10px;
  margin-top: -5px;
  background: rgba(255,255,255,0.2);
}

footer .footBtm .txtFoot02, footer .footBtm .txtFoot03 {
  margin-top: 20px;
  color: rgba(255,255,255,0.6);
  font-size: 0.8rem;
  line-height: 1.5em;
}
footer .footBtm .txtCopy {
  margin-top: 22px;
  color: #fff;
  font-size: 1.6rem;
}
footer .footBtm .txtCopy span {
  display: inline-block;
  position: relative;
  padding: 0 8px 0 9px;
  color: rgba(255,255,255,0.6);
  font-size:  0.8rem;
  line-height: 1.3em;
}
footer .footBtm .txtCopy span:first-child {
  padding-left: 0;
}
@media screen and (min-width: 1024px) and (max-width: 1240px) {
  footer .footInner {
    margin: 0 8% 0 6%;
  }
}
@media screen and (min-width: 768px) and (max-width: 1024px) {
  footer .footBtm .footInner {
    margin: 0%;
    padding: 4% 2%;
  }
}
@media screen and (min-width: 499px) and (max-width: 768px) {
  footer .footBtm .footInner {
    margin: 0 1% 0 1.5%;
    padding: 1% 0;
  }
}

</style>