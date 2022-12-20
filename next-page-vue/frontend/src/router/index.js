import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import PointChargeView from "@/views/Payment/PointChargeView";
import PaymentSuccessView from "@/views/Payment/PaymentSuccessView";
import SignUpView from "@/views/account/SignUpView";
import SignInView from "@/views/account/SignInView";
import MyPageView from "@/views/myPage/MyPageView";
import MyPageModify from "@/component/myPage/MyPageModify";
import MemberJoinForm from "@/component/account/MemberJoinForm";
import MyPageTest from "@/component/myPage/MyPageTest";
import MyPageOut from "@/component/myPage/MyPageOut";
import MyPageNotice from "@/component/myPage/MyPageNotice";
import MyPageQnA from "@/component/myPage/MyPageQnA";




Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },



    // 결제
  {
    path: '/point',
    name: 'PointCharge',
    component: PointChargeView
  },
  {
    path: '/payment-success',
    name: 'PaymentSuccess',
    component: PaymentSuccessView,
    /*components: {
      default: PaymentSuccessView
    },
    props: {
      paymentData: true
    }*/
  },


  {
    path: '/SignUp-View',
    name: 'SignUp-View',
    component: SignUpView
  },

  {
    path: '/SignIn-View',
    name: 'SignIn-View',
    component: SignInView
  },

  {
    path: '/MyPage-View',
    name: 'MyPage-View',
    component: MyPageView
  },

  {
    path: '/MyPage-Modify',
    name: 'MyPage-Modify',
    component: MyPageModify
  },
  {
    path: '/myPage',
    name: 'MyPageView',
    component: MyPageView
  },

  {
    path: '/Member-Join-Form',
    name: 'Member-Join-Form',
    component: MemberJoinForm
  },

  {
    path: '/MyPage-Out',
    name: 'MyPage-Out',
    component: MyPageOut
  },

  {
    path: '/MyPage-Notice',
    name: 'MyPage-Notice',
    component: MyPageNotice
  },

  {
    path: '/MyPage-QnA',
    name: 'MyPage-QnA',
    component: MyPageQnA
  },




  {
    path: '/test', //테스트 용
    name: 'test',
    component: MyPageTest
  },




]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
