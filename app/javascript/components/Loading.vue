<template>
  <div>
    <v-overlay :value="overlay">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
  </div>
</template>

<script>

export default {
  name: 'Loading',
  data() {
    return {
      overlay: false,
    }
  },
  created() {
    this.overlay = true
  },
  watch: {
    overlay (val) {
      val && setTimeout(() => {
        this.overlay = false
      }, 2000)
    }
  }
}
</script>

<style>
</style>