import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import PointChargeView from "@/views/Payment/PointChargeView";
import PaymentSuccessView from "@/views/Payment/PaymentSuccessView";

import NovelInformationRegisterView from "@/views/Upload/NovelInformationRegisterView";
import MemberJoinForm from "@/component/account/MemberJoinForm";
import SignUpView from "@/views/account/SignUpView";
import SignInView from "@/views/account/SignInView";
import QnARegisterView from "@/views/mypage/qna/QnARegisterView";
import QnAListView from "@/views/mypage/qna/QnAListView";
import QnAReadView from "@/views/mypage/qna/QnAReadView";
import QnAModifyView from "@/views/mypage/qna/QnAModifyView";

import NovelListView from "@/views/Upload/NovelListView";


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
    path: '/information-register',
    name: 'NovelInformationRegister',
    component: NovelInformationRegisterView
  },

  { // 회원 약관 동의 UI
    path: '/member-join-form',
    name: 'Member-Join-Form',
    component: MemberJoinForm
  },
  { // 회원가입 UI
    path: '/signUp-view',
    name: 'SignUp-View',
    component: SignUpView
  },
  { // 로그인 UI
    path: '/signin-view',
    name: 'SignIn-View',
    component: SignInView
  },

  {
    path: '/information-list',
    name: 'NovelListView',
    component: NovelListView
  },



  {
    path: '/QnZ-Register-View',
    name: 'QnA-Register-View',
    component: QnARegisterView
  },

  {
    path: '/QnA-List-View',
    name: 'QnA-List-View',
    component: QnAListView
  },


  {
    path: '/QnA-Read-View',
    name: 'QnA-Read-View',
    components: {
      default: QnAReadView
    },
    props: {
      default: true
    }
  },
  {
    path: '/QnA-Modify-View',
    name: 'QnA-Modify-View',
    components: {
      default: QnAModifyView
    },
    props: {
      default: true
    }
  }







]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
