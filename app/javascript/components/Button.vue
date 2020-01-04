<template>
  <v-btn rounded>
    {{ buttonName }}
  </v-btn>
</template>

<script>
  export default {
    name: 'Button',
    props: {
      'buttonName': {
        type: String,
        default: 'ログイン'
      }
    }
  }
</script>

<style scoped>
</style>