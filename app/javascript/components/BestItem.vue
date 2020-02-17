<template>
  <v-card
    max-width="344"
    class="mx-auto"
  >
    <v-list-item>
      <v-list-item-avatar
        v-if="habit.best < 4"
        :color="avatorColor"
      >{{ habit.best }}</v-list-item-avatar>
      <v-list-item-avatar
        v-else
        class="white--text"
        :color="avatorColor"
      >{{ habit.best }}</v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-title class="headline">
          {{ habit.name }}
        </v-list-item-title>
        <v-list-item-subtitle>
          <v-avatar
            color="#990011"
            size="20"
          >
            <img
              :src="avatar(habit.user_id)"
            >
          </v-avatar>
          {{ habit.user_name }}さん
        </v-list-item-subtitle>
      </v-list-item-content>
    </v-list-item>

    <v-card-actions>
      <v-btn
        @click="toggleLike"
        icon
        :disabled="isCurrentUser"
      >
        <v-badge
          color="pink"
          :value="likesCount"
          :content="likesCount"
        >
          <v-icon
            v-if="isLike === true"
            color="red"
          >mdi-heart</v-icon>
          <v-icon v-else>mdi-heart</v-icon>
        </v-badge>
      </v-btn>

        <!-- ここを押すとTwitterでシェアしたり出来るようにしたい -->
      <!-- <v-btn icon>
        <v-icon>mdi-share-variant</v-icon>
      </!-->

      <div v-if="isCurrentUser">
        <v-spacer></v-spacer>
        <router-link :to="{ name: 'HabitEdit' }">
          <v-btn
            text
            color="deep-purple accent-4"
            @click="setHabitDetail(habitId)"
          >
            編集する
          </v-btn>
        </router-link>
      </div>
      <v-spacer></v-spacer>
      <router-link :to="{ name: 'HabitDetail' }">
        <v-btn
          text
          color="deep-purple accent-4"
          @click="setHabitDetail(habitId)"
        >
          詳細を見る
        </v-btn>
      </router-link>
    </v-card-actions>
  </v-card>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'BestItem',
    props: {
      habit: Object,
      avatorColor: '',
      favorites: '',
      isCurrentUser: '',
    },
    computed: {
      ...mapGetters([
        'avatar',
        'currentUser'
      ]),
      likesCount(){
        return this.favorites.filter(favorite => favorite.habit_id === this.habit.id).length
      },
      LikedUsers() {
        return this.favorites.filter( favorite => favorite.habit_id === this.habit.id ).map( f => f.user_id )
      },
      isLike() {
        return this.LikedUsers.includes(this.currentUser.id)
      },
    },
    methods: {
      ...mapActions([
        'addLike',
        'deleteLike',
        'setHabitDetail',
      ]),
      toggleLike() {
        let likeParams = {user_id: this.currentUser.id, habit_id: this.habit.id}
        if (this.isLike === false) {
          this.addLike(likeParams)
          console.log('いいねをつけました')
        } else {
          this.deleteLike(likeParams)
          console.log('いいねを外しました')
        }
      },
    }
  }
</script>

<style>
 h1 {
   font-size: 5rem;
 }
</style>