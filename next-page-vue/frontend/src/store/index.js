import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

import state from "@/store/states";
import actions from "@/store/actions";
import mutations from "@/store/mutations";
import getters from "@/store/getters";

export default new Vuex.Store({
  state,
  actions,
  mutations,
  getters,


})
