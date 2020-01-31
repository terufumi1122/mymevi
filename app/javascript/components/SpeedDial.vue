<template>
  <v-speed-dial
    v-model="fab"
    direction="top"
    :transition="transition"
    open-on-hover
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
    <div v-for="button in buttons" :key="button.id">
      <v-btn
        :rounded="button.rounded"
        :fab="button.fab"
        dark
        :color="button.color"
        @click="$emit('click-button', button.click)"
      >
        <v-icon>{{ button.icon }}</v-icon>
        {{ button.text }}
      </v-btn>
      {{ button.click }}
    </div>
  </v-speed-dial>
</template>

<script>
  export default {
    name: 'SpeedDial',
    props: {
      mainIcon: '',
      buttons: '',
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