<template>
    <v-toolbar
      dense
      floating
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
  }
</script>