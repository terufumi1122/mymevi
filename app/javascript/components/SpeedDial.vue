<template>
  <v-speed-dial
    v-model="fab"
    bottom
    right
    :direction="top"
    :open-on-hover="hover"
    :transition="transition"
    fixed
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
        // direction: 'left',
        fab: false,
        fling: false,
        hover: false,
        tabs: null,
        // top: false,
        // right: true,
        // bottom: true,
        // left: false,
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

    // watch: {
    //   top (val) {
    //     this.bottom = !val
    //   },
    //   right (val) {
    //     this.left = !val
    //   },
    //   bottom (val) {
    //     this.top = !val
    //   },
    //   left (val) {
    //     this.right = !val
    //   },
    // },
  }
</script>