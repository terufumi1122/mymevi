<template>
  <div>
    <v-card
      :loading="loading"
      class="mx-auto my-12"
      max-width="374"
    >
      <v-img
        height="250"
        src="https://cdn.vuetifyjs.com/images/cards/cooking.png"
      ></v-img>

      <v-card-title>{{ currentHabit.name }}</v-card-title>

      <v-card-text>

        <div class="my-4 subtitle-1 black--text">
          詳細
        </div>

        <div>{{ currentHabit.description }}</div>
      </v-card-text>

      <v-divider class="mx-4"></v-divider>

      <v-card-title>こんな人がオススメしています！</v-card-title>

      <div class="my-4 subtitle-1 grey--text">年代、性別、職業などが登録されている分だけ出る</div>

      <v-row
        align="center"
        class="mx-0"
      >
        <v-badge
          color="pink"
          :value="likesCount"
        >
          <v-icon
            color="red"
            @click="toggleLike"
          >mdi-heart</v-icon>
        </v-badge>

      </v-row>
      <v-card-actions>
        <router-link :to="{ name: 'AllBestHabits' }">
          <v-btn
            color="deep-purple accent-4"
            text
          >
            みんなの習慣一覧に戻る
          </v-btn>
        </router-link>
      </v-card-actions>
    </v-card>
  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'
  import axios from 'axios'

  export default {
    name: 'HabitDetail',
    date() {
      return {
        loading: true,
      }
    },
    computed: {
      ...mapGetters ([
        'currentHabitId',
        'allFavorites',
        'currentUser',
        'allHabits'
      ]),
      currentHabit() {
        return this.allHabits.find(habit => habit.id === this.currentHabitId)
      },
      likesCount() {
        return this.allFavorites.filter( favorite => favorite.habit_id === this.currentHabitId ).length
      },
      favorites() {
        return this.allFavorites
      },
      currentUserGender() {
        return this.currentUser.data.gender
      },
      userGender() {
        if(this.currentUserGender === 1) {
          return '男性'
        } else if(this.currentUserGender === 2 ) {
          return '女性'
        } else {
          return ''
        }
      }
    },
    created() {
      const userId = this.currentUser.data.id
      this.setCurrentUserHabits(userId)
      this.setAllFavorites()
    },
    mounted() {
      this.loading = false

      const userId = this.currentUser.data.id
      axios
        .get(`/api/v1/users/${userId}.json`)
        .then(response => (this.user = response.data))
    },
    methods: {
      ...mapActions ([
        'setAllFavorites',
        'setCurrentUserHabits',
        'addLike',
        'deleteLike'
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
    }
  }
</script>