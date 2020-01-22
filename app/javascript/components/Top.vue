<template>
  <v-content>
    <v-container>
      <v-row>
        <v-col><About/></v-col>
      </v-row>
      <v-row>
        <!-- デモGIFが出来たら表示する -->
        <!-- <v-col><Demo/></v-col> -->
      </v-row>
    </v-container>
  </v-content>
</template>

<script>
import { mapMutations } from 'vuex'

import About from "./About.vue"
import Demo from "./Demo.vue"

  export default {
    name: 'Top',
    components: {
      About,
      Demo,
    },
  }
</script>

<style>
  h1 {
    text-align: center;
  }
</style>