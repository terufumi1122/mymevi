<template>
  <v-card
    max-width="344"
    class="mx-auto"
  >
    <v-list-item>
      <v-list-item-avatar :color="avatorColor">{{ habitNumber }}</v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-title class="headline">{{ habitTitle }}</v-list-item-title>
        <v-list-item-subtitle>{{ userName }}</v-list-item-subtitle>
      </v-list-item-content>
    </v-list-item>

    <!-- <v-card-text>
      (習慣の説明が記載される)Lorem ipsum dolor sit amet, consectetur adipiscing elit...
    </v-card-text> -->
    <!-- ここは詳細を押したら表示されるようにしたい -->

    <v-card-actions>
      <v-btn
        icon
        @click="toggleLike"
      >
          <v-icon v-if="like === liked">mdi-heart</v-icon>
          <v-icon v-else color="red">mdi-heart</v-icon>
        <!-- いいね！数も掲載 -->
      </v-btn>
      <v-btn icon>
        <v-icon>mdi-share-variant</v-icon>
        <!-- ここを押すとTwitterでシェアしたり出来る -->
      </v-btn>
      <v-spacer></v-spacer>
      <v-btn
        text
        color="deep-purple accent-4"
      >
        詳細
      </v-btn>
      <v-btn
        text
        color="deep-purple accent-4"
      >
        お気に入り登録
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
  export default {
    name: 'BestItem',
    props: {
      habitNumber: '',
      habitTitle: '',
      userName: '',
      avatorColor: '',
      like: '',
    },
    data() {
      return {
        liked: false
      }
    },
    methods: {
      toggleLike() {
        this.liked = !this.liked
      }
    }
  }
</script>

<style>
 h1 {
   font-size: 5rem;
 }
</style>