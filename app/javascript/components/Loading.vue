<template>
  <div>
    <v-overlay
      :value="loading"
      color="#f0efe2"
      opacity="1.0"
    >
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Loading',
  computed: {
    ...mapGetters([
      'loading'
    ])
  },
}
</script>

<style>
</style>