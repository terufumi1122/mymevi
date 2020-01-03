<template>
  <header id="header">
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

      <v-toolbar-title><router-link :to="{ name: 'Top' }">Mymevi</router-link></v-toolbar-title>
      <v-spacer></v-spacer>
      
      <v-btn icon>
        <v-icon>mdi-heart</v-icon>
      </v-btn>
      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>
      <v-btn icon>
        <v-icon>mdi-help-circle</v-icon>
      </v-btn>
      <v-btn @click="signOut">
        ログアウト
      </v-btn>

      <v-menu>
        <template v-slot:activator="{ on }">
          <v-btn icon v-on="on">
            <v-icon>mdi-dots-vertical</v-icon>
          </v-btn>
        </template>

        <v-list>
          <v-list-item
            v-for="n in 5"
            :key="n"
            @click="() => {}"
          >
            <v-list-item-title>Option {{ n }}</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>
  </header>
</template>

<script>
import axios from 'axios'
import UsersIndex from './UsersIndex.vue'
import UserDetail from './UserDetail.vue'
import UsersEdit from './UserEdit.vue'

  export default {
    name: 'Header',
    data() {
      user: {}
    },
    components: {
      UsersIndex,
      UserDetail,
      UsersEdit
    },
    data() {
      return {
        links: [
          {id: '1', name: 'UserIndex', displayName: 'ユーザー一覧'},
          {id: '2', name: 'UserDetail', displayName: 'ユーザー詳細'},
          {id: '3', name: 'UserEdit', displayName: 'ユーザー編集'}
        ]
      }
    },
    methods: {
      signOut: function() {
        axios
          .delete('/api/v1/auth/sign_out',
                  { headers: { "access-token": token, "client": client, "uid": uid} })
          .then(this.$router.push({ name: 'Top'}))
          .catch(error => {
            console.error(error);
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
          });
      },
    }
  }
</script>

<style>
</style>