<template>
  <v-container id="info">
      <h3 v-if="isCurrentUser">{{ title }}</h3>
      <p>{{ address }}</p>
      <v-row>
        <v-spacer></v-spacer>
        <v-btn
          :color="color1"
          dark
          :to="{ name: routeTo1 }"
          @click="$emit('clickButton1')"
        >
        <v-icon>{{ icon1 }}</v-icon>
          {{ routeToText1 }}
        </v-btn>
        <v-spacer></v-spacer>
        <v-btn
          v-if="isCurrentUser"
          :color="color2"
          dark
          :to="{ name: routeTo2 }"
          @click="$emit('clickButton2')"
        >
        <v-icon>{{ icon2 }}</v-icon>
          {{ routeToText2 }}
        </v-btn>
        <v-spacer></v-spacer>
      </v-row>
  </v-container>
</template>

<script>
  export default {
    name: 'InfoWindow',
    props: {
      isCurrentUser: '',
      title: '',
      address: '',
      color1: '',
      color2: '',
      icon1: '',
      icon2: '',
      routeTo1: '',
      routeTo2: '',
      routeToText1: '',
      routeToText2: '',
      clickButton1: '',
      clickButton2: '',
    }
  }
</script>