<template>
  <v-content>
    <v-container class="about__wrapper">
      <v-row>
        <v-spacer></v-spacer>
        <img
          src="../../assets/images/002-infinity.svg"
          alt="メインロゴ"
          class="main__logo"
        >
        <v-spacer></v-spacer>
      </v-row>
      <v-row>
        <v-spacer></v-spacer>
        <p><strong>マイメビ</strong>は、みんながうまくいった習慣を共有するサービスです。</p>
        <v-spacer></v-spacer>
      </v-row>
      <v-row v-if="currentUser === null">
        <v-spacer></v-spacer>
        <router-link :to="{ name: 'LoginForm' }">
          <v-btn
            color="#0f4c81"
            dark
          >
            ログイン
          </v-btn>
        </router-link>
        <v-spacer></v-spacer>
        <!-- 簡単ログイン機能を付ける -->
          <v-btn
            color="#278040"
            dark
            @click="guestLogin"
          >
            簡単ログイン
          </v-btn>
        <!--  -->
          <v-spacer></v-spacer>
        <router-link :to="{ name: 'SignUpForm' }">
          <v-btn
            color="#990011"
            dark
          >
            新規登録
          </v-btn>
        </router-link>
        <v-spacer></v-spacer>
      </v-row>
    </v-container>
  </v-content>
</template>

<script>
  import { mapGetters, mapMutations, mapActions } from 'vuex'
  import Button from './Button.vue'

  export default {
    name: 'About',
    components: {
      Button,
    },
    computed: {
      ...mapGetters([
        'currentUser'
      ])
    },
    methods: {
      ...mapMutations([
        'flashSampleLogin'
      ]),
      ...mapActions([
        'sampleLogin'
      ]),
      guestLogin() {
        this.sampleLogin()
        this.flashSampleLogin()
      }
    }
  }
</script>

<style scoped>
  .about__wrapper {
    text-align: center;
  }
  .main__logo {
    width: 80%;
    margin-bottom: 20px;
  }
</style>