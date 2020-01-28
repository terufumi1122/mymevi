<template>
  <div>
    <v-alert
      v-if="flash !== null"
      :type="flash.type"
      dismissible
      transition="slide-y-transition"
    >
      {{ flash.message }}
    </v-alert>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex';

  export default {
    name: 'Flash',
    computed: {
      ...mapGetters([
        'flash'
      ]),
    },
  }
</script>

<style>
</style>