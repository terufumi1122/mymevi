<template>
  <v-content>
    <v-container>
      <Flash/>
      <v-row>
        <v-col><About/></v-col>
      </v-row>
      <v-row>
        <v-col><Demo/></v-col>
      </v-row>
    </v-container>
  </v-content>
</template>

<script>

import About from "./About.vue"
import Demo from "./Demo.vue"
import Flash from "./Flash.vue"

  export default {
    name: 'Top',
    components: {
      About,
      Demo,
      Flash,
    },
    destroyed() {
      this.$store.state.flash = '';
    }
  }
</script>

<style>
  h1 {
    text-align: center;
  }
</style>