<template>
    <v-toolbar
      dense
      floating
      max-width="maxWidth"
      class="mx-1"
    >
      <v-text-field
        v-model="keyword"
        hide-details
        single-line
      ></v-text-field>

      <v-btn
        icon
        @click="$emit('search', keyword)"
      >
        <v-icon>mdi-magnify</v-icon>
      </v-btn>

    </v-toolbar>
</template>

<script>
  export default {
    name: 'SearchBox',
    data() {
      return {
        keyword: '',
      }
    },
    computed: {
      maxWidth() {
        return window.innerWidth - 120
      }
    }
  }
</script>