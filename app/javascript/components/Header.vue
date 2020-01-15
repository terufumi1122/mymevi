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
            <img src="../../assets/images/002-infinity.svg" alt="ヘッダーロゴ" width="25px" height="25px">
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
            v-for="n in 5"
            :key="n"
            @click="() => {}"
          >
            <v-list-item-title>Option {{ n }}</v-list-item-title>
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
  export default {
    name: 'Header',
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