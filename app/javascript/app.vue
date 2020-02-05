<template>
  <v-app id="app">
    <div>
      <Header/>
      <Flash/>
      <router-view
      class="main__view--margin"
      ></router-view>
      <Footer/>
    </div>
    <!-- ローディング画面は一旦なし -->
    <!-- <Loading/> -->
  </v-app>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';

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
  computed: {
    ...mapGetters([
      'currentUser',
    ])
  },
  mounted() {
    if (localStorage.currentUser) {
      this.setCurrentUser(JSON.parse(localStorage.getItem('currentUser')));
    }
    if (localStorage.headers) {
      this.setHeaders(JSON.parse(localStorage.getItem('headers')));
    }
  },
  methods: {
    ...mapActions([
      'setCurrentUser',
      'setHeaders',
    ])
  }
}
</script>

<style>
#app {
  background: #f0efe2;
  height: 100vh;
  overflow-y: scroll;
}
.main__view--margin {
  margin-bottom: 56px;
}
</style>