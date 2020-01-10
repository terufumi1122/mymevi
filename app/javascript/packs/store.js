import 'babel-polyfill'
import Vue from 'vue'
import Vuex from 'vuex'

// storeモジュールの読み込み
import userStore from './stores/user.js'
import habitStore from './stores/habit.js'
import flashStore from './stores/flash.js'
import favoriteStore from './stores/favorite.js'

// import axios from 'axios'

Vue.use(Vuex)

const store = new Vuex.Store({

  modules: {
    userStore,
    habitStore,
    flashStore,
    favoriteStore,
  },

  state: {
  },

  getters: {
  },

  mutations: {
  },

  actions: {
  },

})

export default store