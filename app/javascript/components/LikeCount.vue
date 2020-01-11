<template>
  <div>
    <v-text>{{ likeCount }}</v-text>
  </div>
</template>

<script>
  export default {
    name: 'LikeCount',
    props: {
      habit: {},
      

    },
    computed: {

    }
  }
</script>