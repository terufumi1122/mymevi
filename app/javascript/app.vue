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

const router = new VueRouter({
  routes: [
    { path: '/',
      component: UsersIndex },
    { path: '/users/:id(\\d+)',
      component: UserDetail }
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