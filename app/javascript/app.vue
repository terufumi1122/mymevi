<template>
  <v-app id="app">
    <Loading v-show="loading"/>
    <div v-show="!loading">
      <Header/>
      <Flash/>
      <router-view class="main__view--margin_bottom"></router-view>
      <Footer/>
    </div>
  </v-app>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex';

import Loading from './components/Loading'
import Header from './components/Header'
import Flash from './components/Flash'
import Footer from './components/Footer'


export default {
  name: 'App',
  components: {
    Loading,
    Header,
    Flash,
    Footer,
  },
  data() {
    return {
      loading: true,
    }
  },
  // computed: {
  //   ...mapGetters([
  //     'flash'
  //   ])
  // },
  mounted() {
    setTimeout(() => {
      this.loading = false
    }, 1000);
    // console.log('まうんてっど')
    // setTimeout(() => {this.deleteFlash}, 3000)
    // console.log('deleteFlashの後ろの行')
    // console.log(this.flash)
  },
  // methods: {
  //   ...mapMutations([
  //     'deleteFlash'
  //   ])
  // }
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