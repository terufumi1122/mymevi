<template>
  <v-bottom-navigation background-color="#990011" dark fixed>
      <v-btn
        v-if="currentUser"
        :to="{ name: 'UserDetail' }"
      >
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
import { mapGetters } from 'vuex'

export default {
  name: "Footer",
  computed: {
    ...mapGetters([
      'currentUser'
    ])
  }
};
</script>
