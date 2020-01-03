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
  export default {
    name: 'Header',
    data() {
      user: {}
    },
    data() {
      return {
      }
    },
    methods: {
    }
  }
</script>

<style>
</style>