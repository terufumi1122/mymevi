import 'babel-polyfill'
import Vue from 'vue'
import Vuex from 'vuex'

import userStore from './stores/user.js'
import habitStore from './stores/habit.js'
import flashStore from './stores/flash.js'
import favoriteStore from './stores/favorite.js'
import locationStore from './stores/location.js'


Vue.use(Vuex)

const store = new Vuex.Store({
  strict: process.env.NODE_ENV !== 'production',

  modules: {
    userStore,
    habitStore,
    flashStore,
    favoriteStore,
    locationStore,
  },

})

export default store