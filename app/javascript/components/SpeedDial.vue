<template>
  <v-speed-dial
    v-model="fab"
    direction="top"
    :transition="transition"
    fixed
    class="speed-dial__position"
  >
    <template v-slot:activator>
      <v-btn
        v-model="fab"
        color="blue darken-2"
        dark
        fab
      >
        <v-icon v-if="fab">mdi-close</v-icon>
        <v-icon v-else>{{ mainIcon }}</v-icon>
      </v-btn>
    </template>
    <v-btn
      fab
      dark
      small
      :color="color1"
      @click="click1"
    >
      <v-icon>{{ icon1 }}</v-icon>
    </v-btn>
    <v-btn
      fab
      dark
      small
      :color="color2"
      @click="click2"
    >
      <v-icon>{{ icon2 }}</v-icon>
    </v-btn>
    <v-btn
      fab
      dark
      small
      :color="color3"
      @click="click3"
    >
      <v-icon>{{ icon3 }}</v-icon>
    </v-btn>
  </v-speed-dial>
</template>

<script>
  export default {
    name: 'SpeedDial',
    props: {
      mainIcon: '',
      icon1: '',
      icon2: '',
      icon3: '',
      color1: '',
      color2: '',
      color3: '',
      click1: '',
      click2: '',
      click3: '',
    },

    data() {
      return {
        fab: false,
        fling: false,
        tabs: null,
        transition: 'slide-y-reverse-transition',
      }
    },

    computed: {
      activeFab () {
        switch (this.tabs) {
          case 'one': return { class: 'purple', icon: 'account_circle' }
          case 'two': return { class: 'red', icon: 'edit' }
          case 'three': return { class: 'green', icon: 'keyboard_arrow_up' }
          default: return {}
        }
      },
    },

  }
</script>

<style>
.speed-dial__position {
  bottom: 100px;
  right: 80px;
}
</style>