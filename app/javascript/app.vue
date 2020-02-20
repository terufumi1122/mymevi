<template>
  <v-app id="app" v-cloak>
    <div>
      <Header/>
      <Flash/>
      <router-view
        class="router__view--margin"
      ></router-view>
      <Footer/>
    </div>
  </v-app>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex';

import Header from './components/Header'
import Flash from './components/Flash'
import Footer from './components/Footer'

export default {
  name: 'App',
  components: {
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
      this.getAvatar()
    }
    if (localStorage.headers) {
      this.setHeaders(JSON.parse(localStorage.getItem('headers')));
    }
  },
  methods: {
    ...mapActions([
      'setCurrentUser',
      'setHeaders',
      'getAvatar'
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
[v-cloak] {
  display: none;
}
.router__view--margin {
  margin-top: 56px;
  margin-bottom: 56px;
}
</style>