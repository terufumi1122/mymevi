<template>
  <v-app id="app">
    <Header/>
    <Top/>
    <Footer/>
  </v-app>
</template>

<script>
import Top from "./components/Top";
import Header from "./components/Header";
import Footer from "./components/Footer";

export default {
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