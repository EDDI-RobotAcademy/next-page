import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import PointChargeView from "@/views/Payment/PointChargeView";
import PaymentSuccessView from "@/views/Payment/PaymentSuccessView";
import NovelInformationRegisterView from "@/views/Upload/NovelInformationRegisterView";

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


]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
