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
  import { mapGetters, mapMutations } from 'vuex';

  export default {
    name: 'Flash',
    computed: {
      ...mapGetters([
        'flash'
      ]),
    },
    methods: {
      ...mapMutations([
        'deleteFlash',
      ])
    },
    updated() {
      console.log('あっぷでーてぃっど')

      setTimeout(this.deleteFlash, 3000);
      
      console.log('関数のあとです')
    }
  }
</script>

<style>
/* .alert--message {
  position: fixed;
} */
</style>