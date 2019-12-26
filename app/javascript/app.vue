<template>
  <v-app id="app">
    <Header/>
    <Top/>
    <Footer/>
    <router-view></router-view>
  </v-app>
</template>

<script>
import Top from "./components/Top";
import Header from "./components/Header";
import Footer from "./components/Footer";

import Vue from 'vue'
import VueRouter from 'vue-router'

import UsersIndex from './components/UsersIndex.vue'
import UserDetail from './components/UserDetail.vue'
import UserNew from './components/UserNew.vue'
import NotFound from './components/NotFound.vue'

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/',
      name: 'UsersIndex',
      component: UsersIndex },
    { path: '/users/:id(\\d+)',
      name: 'UserDetail',
      component: UserDetail },
    { path: '/users/new',
      name: 'UserNew',
      component: UserNew },
    { path: '*',
      name: 'NotFound',
      component: NotFound },
  ]
})

Vue.use(VueRouter)

export default {
  router,
  data: function () {
    return {
    }
  },
  components: {
    Header,
    Top,
    Footer,
  }
}
</script>

<style>
#app {
  background: #f0efe2;
}
</style>