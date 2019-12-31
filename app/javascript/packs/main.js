// webpackエントリーポイント
import Vue from 'vue'
import Vuetify from 'vuetify' //追加
import "vuetify/dist/vuetify.min.css" //追加
import App from '../App.vue'
import store from './store.js'
import router from './router.js'

Vue.use(Vuetify) //追加

const vuetify = new Vuetify(); //追加

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify, //追加
    store,
    router,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
  console.log(store)
  console.log(store.state.count)
})