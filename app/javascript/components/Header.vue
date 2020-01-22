<template>
    <v-app-bar
      color="#0f4c81"
      dark
    >
      <v-app-bar-nav-icon>
        <v-menu>
          <template v-slot:activator="{ on }">
            <v-btn icon v-on="on">
              <v-icon>mdi-menu</v-icon>
            </v-btn>
          </template>
          <v-list>
            <v-list-item
              v-for="n in 5"
              :key="n"
              @click="() => {}"
            >
              <v-list-item-title>Link {{ n }}</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>        
      </v-app-bar-nav-icon>

      <v-toolbar-title>
        <router-link :to="{ name: 'Top' }">
          <div class="my-4 title white--text inline-flex">
            <img src="../../assets/images/infinity.svg" alt="ヘッダーロゴ" width="25px" height="25px">
            MyMevi
          </div>
        </router-link>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      
      <v-btn icon>
        <router-link :to="{ name: 'AllBestHabits' }">
          <v-icon>mdi-heart</v-icon>
        </router-link>
      </v-btn>
      <v-btn icon>
        <router-link :to="{ name: 'UserDetail' }">
          <v-icon>mdi-account-circle</v-icon>
        </router-link>
      </v-btn>
      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>
      <v-btn icon>
        <v-icon>mdi-help-circle</v-icon>
      </v-btn>

      <v-menu>
        <template v-slot:activator="{ on }">
          <v-btn icon v-on="on">
            <v-icon>mdi-dots-vertical</v-icon>
          </v-btn>
        </template>

        <v-list>
          <v-list-item
            v-for="setting in afterLoginSettings"
            :key="setting.id"
            @click="triggerClick(setting.action)"
          >
            <router-link :to="{ name: setting.link }">
              <v-list-item-title>
                {{ setting.name }}
              </v-list-item-title>
            </router-link>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>
    <!-- <v-sheet
      id="scrolling-area-1"
      class="overflow-y-auto"
      max-height="600"
    >
    </v-sheet> -->
</template>

<script>
  import { mapGetters, mapMutations, mapActions } from 'vuex'

  export default {
    name: 'Header',
    data() {
      return {
        settings: [
          {id: 1, afterLogin: false, name: '新規ユーザー登録', link: 'SignUpForm', action: ''},
          {id: 2, afterLogin: false, name: 'ログイン', link: 'LoginForm', action: ''},
          {id: 3, afterLogin: false, name: '簡単ログイン', link: '', action: 'guestLogin'},
          {id: 4, afterLogin: true, name: 'ログアウト', link: '', action: 'signOutUser'},
        ]
      }
    },
    computed: {
      ...mapGetters([
        'currentUser'
      ]),
      logined(){
        return this.currentUser !== null
      },
      afterLoginSettings(){
        if (this.currentUser !== null) {
          return this.settings.filter(setting => setting.afterLogin === true)
        } else {
          return this.settings.filter(setting => setting.afterLogin === false)
        }
      }
    },
    methods: {
      ...mapMutations([
        'flashSampleLogin',
        'flashSignIn',
        'flashSignOut',
      ]),
      ...mapActions([
        'sampleLogin',
        'signOut',
      ]),
      triggerClick(action) {
        if (action === 'guestLogin') {
          this.sampleLogin()
          this.flashSampleLogin() 
        } else if(action === 'signOutUser') {
          this.signOut()
          this.$router.push({ name: 'Top' })
          this.flashSignOut()
        } 
      }
    }
  }
</script>

<style>
</style>