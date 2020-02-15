<template>
  <v-bottom-navigation background-color="#990011" dark fixed>
    <v-btn :to="{ name: 'UserDetail' }">
      <span>自分の習慣</span>
      <v-icon>mdi-account-circle</v-icon>
    </v-btn>

    <v-btn :to="{ name: 'AllBestHabits' }">
      <span>みんなの習慣</span>
      <v-icon>mdi-heart</v-icon>
    </v-btn>

    <v-btn :to="{ name: 'GoogleMap' }">
      <span>定番スポット</span>
      <v-icon>mdi-map-marker</v-icon>
    </v-btn>
  </v-bottom-navigation>
</template>

<script>
export default {
  name: "Footer"
};
</script>
