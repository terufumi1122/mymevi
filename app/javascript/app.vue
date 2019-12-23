<template>
  <v-app id="app">
    <Header/>
    <Top/>
  </v-app>
</template>

<script>
import Top from "./components/Top";
import Header from "./components/Header";

export default {
  data: function () {
    return {
    }
  },
  components: {
    Header,
    Top,
  }
}
</script>

<style>
#app {
  background: #f0efe2;
}
</style>