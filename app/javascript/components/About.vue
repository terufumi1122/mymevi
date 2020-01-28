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
          <v-btn
            color="#278040"
            dark
            @click="guestLogin"
          >
            簡単ログイン
          </v-btn>
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
      <v-row v-else>
        <div>
          <h2>早速使ってみよう！</h2>
        </div>
        <div>
          <v-icon>mdi-account-circle</v-icon>:自分のプロフィール・習慣の確認・習慣の投稿
        </div>
        <div>
          <v-icon>mdi-heart</v-icon>:みんなのオススメ習慣を見る
        </div>
      </v-row>
    </v-container>
  </v-content>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'
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
      ...mapActions([
        'sampleLogin',
      ]),
      guestLogin() {
        this.sampleLogin(this.routeTo('Top'))
      },
      routeTo(routeName) {
        this.$router.push({ name: routeName })
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
    max-width: 500px;
    margin-bottom: 20px;
  }
</style>