<template>
  <v-content>
    <v-container class="mx-auto about__wrapper">
      <v-row>
        <v-spacer></v-spacer>
        <img
          v-if="currentUser === null"
          src="../../assets/images/002-infinity.svg"
          alt="メインロゴ"
          class="main__logo"
        >
        <img
          v-else
          src="../../assets/images/002-infinity.svg"
          alt="メインロゴ"
          class="main__logo main__logo--after"
        >
        <v-spacer></v-spacer>
      </v-row>
      <v-row>
        <v-spacer></v-spacer>
        <p><strong>マイメビ</strong>は、自分の<strong>イチオシ習慣</strong>を<strong>匿名</strong>でシェア出来るサービスです。</p>
        <v-spacer></v-spacer>
      </v-row>
      <v-container v-if="currentUser === null">
        <v-row>
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
      </v-container>
      <v-container v-else>
        <v-row>
          <div class="mx-auto">
            <h2>早速使ってみよう！</h2>
          </div>
        </v-row>
        <v-row>
          <v-btn
            class="mx-auto mb-3"
            color="green"
            dark
            :to="{ name: 'UserDetail' }"
          >
            <v-icon>mdi-account-circle</v-icon>:自分のプロフィール・習慣
          </v-btn>
        </v-row>
        <v-row>
          <v-btn
            class="mx-auto mb-3"
            color="green darken-2"
            dark
            :to="{ name: 'AllBestHabits' }"
          >
            <v-icon>mdi-heart</v-icon>:みんなのオススメ習慣
          </v-btn>
        </v-row>
        <v-row>
          <v-btn
            class="mx-auto mb-3"
            color="green darken-4"
            dark
            :to="{ name: 'GoogleMap' }"
          >
            <v-icon>mdi-map-marker</v-icon>:みんなの定番スポット
          </v-btn>
        </v-row>
      </v-container>
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
    height: 50vh;
    max-width: 500px;
    margin-bottom: 20px;
  }
  .main__logo--after {
    height: 40vh;
    max-width: 200px;
    margin-bottom: 20px;
  }
</style>