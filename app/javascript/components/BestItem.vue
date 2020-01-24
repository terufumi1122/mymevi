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

    <v-card-actions>
      <v-btn
        @click="toggleLike"
        icon
        :disabled="isDisabled"
      >
        <v-badge
          color="pink"
          :value="likeCount"
          :content="likeCount"
        >
          <v-icon
            v-if="isLike === true"
            color="red"
          >mdi-heart</v-icon>
          <v-icon v-else>mdi-heart</v-icon>
        </v-badge>
      </v-btn>
      <v-btn icon>
        <v-icon>mdi-share-variant</v-icon>
        <!-- ここを押すとTwitterでシェアしたり出来る -->
      </v-btn>
      <v-spacer></v-spacer>
      <router-link :to="{ name: 'HabitDetail' }">
        <v-btn
          text
          color="deep-purple accent-4"
          @click="setHabit"
        >
          詳細を見る
        </v-btn>
      </router-link>
    </v-card-actions>
  </v-card>
</template>

<script>
  import { mapActions } from 'vuex'

  export default {
    name: 'BestItem',
    props: {
      habitNumber: '',
      habitTitle: '',
      userName: '',
      avatorColor: '',
      habitId: '',
      userId: '',
      favorites: '',
      isDisabled: ''
    },
    computed: {
      likeCount(){
        return this.favorites.filter(favorite => favorite.habit_id === this.habitId).length
      },
      LikedUsers() {
        return this.favorites.filter( favorite => favorite.habit_id === this.habitId ).map( f => f.user_id )
      },
      isLike() {
        return this.LikedUsers.includes(this.userId)
      }
    },
    methods: {
      ...mapActions([
        'addLike',
        'deleteLike',
        'setCurrentHabitId'
      ]),
      toggleLike() {
        let likeParams = {user_id: this.userId, habit_id: this.habitId}
        if (this.isLike === false) {
          this.addLike(likeParams)
          console.log('いいねをつけました')
        } else {
          this.deleteLike(likeParams)
          console.log('いいねを外しました')
        }
      },
      setHabit() {
        this.setCurrentHabitId(this.habitId)
      }
    }
  }
</script>

<style>
 h1 {
   font-size: 5rem;
 }
</style>