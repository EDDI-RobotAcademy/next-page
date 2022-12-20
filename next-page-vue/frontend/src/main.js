import Vue from 'vue'
import Vuex from "vuex";
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify'

Vue.config.productionTip = false

new Vue({
  router,
  store,
  Vuex,
  vuetify,
  render: h => h(App)
}).$mount('#app')
