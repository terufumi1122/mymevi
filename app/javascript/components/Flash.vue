<template>
    <v-alert
      v-if="flash !== null"
      :type="flash.type"
      width="100%"
      dismissible
      transition="scale-transition"
      class="flash-message__position"
    >
      {{ flash.message }}
    </v-alert>
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
.flash-message__position {
  position: fixed;
  top: 56px;
  left: 0;
  z-index: 100;
}
</style>