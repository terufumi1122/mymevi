<template>
  <v-bottom-navigation
    background-color="#990011"
    dark
    fixed
  >
    <v-btn>
      <span>Recent</span>
      <v-icon>mdi-history</v-icon>
    </v-btn>

    <v-btn>
      <span>Faborites</span>
      <v-icon>mdi-heart</v-icon>
    </v-btn>

      <v-btn
        :to="{name: 'GoogleMap'}"
      >
        <span>Map</span>
        <v-icon>mdi-map-marker</v-icon>
      </v-btn>
  </v-bottom-navigation>
</template>

<script>
  export default {
    name: 'Footer',
  }
</script>