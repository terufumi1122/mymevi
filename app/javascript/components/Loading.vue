<template>
  <div v-show="loading">
    <div class="fullview">
      <div class="loading-spacer"></div>
      <v-text-field color="success" loading disabled></v-text-field>
    </div>
  </div>
</template>

<script>

export default {
  name: 'Loading',
}
</script>

<style>
.fullview {
  width: 100%;
  height: 100%;
  background: #fefefe;
  position: fixed;
  top: 0;
  left: 0;
}
.loading-spacer {
  height: 40vh;
}
</style>