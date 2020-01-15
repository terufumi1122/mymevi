<template>
  <v-app id="app">
    <Loading v-show="loading"></Loading>
    <div v-show="!loading">
      <Header/>
      <router-view class="main__view--margin_bottom"></router-view>
      <Footer/>
    </div>
  </v-app>
</template>

<script>
import Loading from './components/Loading'
import Header from './components/Header'
import Footer from './components/Footer'

export default {
  name: 'App',
  components: {
    Loading,
    Header,
    Footer,
  },
  data() {
    return {
      loading: true,
    }
  },
  mounted() {
    setTimeout(() => {
      this.loading = false;
    }, 1000);
  }
}
</script>

<style>
#app {
  background: #f0efe2;
  height: 100vh;
  overflow-y: scroll;
}
.main__view--margin_bottom {
  margin-bottom: 56px;
}
</style>