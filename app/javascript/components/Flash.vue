<template>
  <v-alert v-if="flash !== ''" type="success">
    {{ flash }}
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