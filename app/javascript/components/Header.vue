<template>
    <v-app-bar
      color="#0f4c81"
      dark
    >
      <v-toolbar-title>
        <v-btn
          :to="{ name: 'Top' }"
          color="transparent"
        >
          <img src="../../assets/images/infinity.svg" alt="ヘッダーロゴ" width="25px" height="25px">
            <span>
              MyMevi
            </span>
        </v-btn>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      
      <v-menu>
        <template v-slot:activator="{ on }">
          <v-btn icon v-on="on">
            <v-icon>mdi-menu</v-icon>
          </v-btn>
        </template>

        <v-list>
          <v-list-item
            v-for="setting in afterLoginSettings"
            :key="setting.id"
            @click="triggerClick(setting.action)"
          >
              <v-list-item-title
                :to="{ name: setting.link }"
              >
                {{ setting.name }}
              </v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'

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
      ...mapActions([
        'sampleLogin',
        'signOut',
      ]),
      triggerClick(action) {
        if (action === 'guestLogin') {
          this.sampleLogin(this.routeTo('Top'))
        } else if(action === 'signOutUser') {
          this.signOut(this.routeTo('Top'))
        } 
      },
      routeTo(routeName) {
        this.$router.push({ name: routeName })
      }
    }
  }
</script>