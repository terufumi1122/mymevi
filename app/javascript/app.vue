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

export default {
  name: 'App',
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