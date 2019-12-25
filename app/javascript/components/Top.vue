<template>
  <v-content>
    <v-container>
      <v-row>
        <v-col><About/></v-col>
      </v-row>
      <v-row>
        <v-col><Demo/></v-col>
      </v-row>
    </v-container>
    <v-container>
      <Users/>
    </v-container>
  </v-content>
</template>

<script>

import About from "./About.vue"
import Demo from "./Demo.vue"
import BestItem from "./BestItem.vue"
import Users from "./Users.vue"

  export default {
    name: 'Top',
    components: {
      About,
      Demo,
      BestItem,
      Users,
    }
  }
</script>

<style>
  h1 {
    text-align: center;
  }
</style>