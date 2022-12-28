import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

import createPersistedState from "vuex-persistedstate";

import state from "@/store/states";
import actions from "@/store/actions";
import mutations from "@/store/mutations";
import getters from "@/store/getters";

export default new Vuex.Store({

  plugins: [
    createPersistedState( {
      paths: ['isAuthenticated']
    })
  ],

  state,
  actions,
  mutations,
  getters,


})
