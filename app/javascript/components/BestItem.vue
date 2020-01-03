<template>
  <v-card
    max-width="344"
    class="mx-auto"
  >
    <v-list-item>
      <v-list-item-avatar color="yellow">1</v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-title class="headline">Habit title</v-list-item-title>
        <v-list-item-subtitle>by User name</v-list-item-subtitle>
      </v-list-item-content>
    </v-list-item>

    <!-- <v-card-text>
      (習慣の説明が記載される)Lorem ipsum dolor sit amet, consectetur adipiscing elit...
    </v-card-text> -->
    <!-- ここは詳細を押したら表示されるようにしたい -->

    <v-card-actions>
      <v-btn icon>
          <v-icon>mdi-heart</v-icon>
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
  }
</script>

<style>
 h1 {
   font-size: 5rem;
 }
</style>