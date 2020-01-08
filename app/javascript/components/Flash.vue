<template>
  <v-alert
    v-if="flash.status !== null"
    :type="flash.type"
    dismissible
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
      ])
    },
  }
</script>