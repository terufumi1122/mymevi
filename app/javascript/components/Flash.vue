<template>
  <v-alert v-if="flash.status !== null" :type="flash.type">
    {{ flash.message }}
  </v-alert>
</template>

<script>
  export default {
    name: 'Flash',
    computed: {
      flash() {
        return this.$store.state.flash
      }
    },
  }
</script>