import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import PointChargeView from "@/views/Payment/PointChargeView";
import PaymentSuccessView from "@/views/Payment/PaymentSuccessView";

import NovelInformationRegisterView from "@/views/Upload/NovelInformationRegisterView";
import MemberJoinForm from "@/component/account/MemberJoinForm";
import SignUpView from "@/views/account/SignUpView";
import SignInView from "@/views/account/SignInView";


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










]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
