<template>
  <v-app id="app">
    <Header/>
    <router-view></router-view>
    <Footer/>
  </v-app>
</template>

<script>
import Header from './components/Header'
import Footer from './components/Footer'

export default {
  name: 'App',
  components: {
    Header,
    Footer,
  }
}
</script>

<style>
#app {
  background: #f0efe2;
}
</style>