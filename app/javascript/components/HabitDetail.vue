<template>
  <div>
    <v-card
      :loading="loading"
      class="mx-auto my-12"
      max-width="374"
    >
      <v-img
        v-if="habit.image"
        haight="250"
        :src="habit.image"
        alt="登録した習慣の画像"
      ></v-img>
      <v-img
        v-else
        height="250"
        src="https://cdn.vuetifyjs.com/images/cards/cooking.png"
        alt="デフォルト画像"
      ></v-img>

      <v-card-title>{{ habit.name }}</v-card-title>

      <v-card-text>
        <div>詳細：{{ habit.description }}</div>
        <div>場所：{{ habitLocation.name }}</div>
        <div>場所：{{ habit.location_name }}</div>
      </v-card-text>

      <v-divider class="mx-4"></v-divider>

      <v-card-title>こんな人がオススメしています！</v-card-title>

      <div class="my-4 subtitle-1 grey--text">
        {{ habit.user_name }}{{ userGender }}さんの{{ habit.best }}番目のオススメ習慣です！
      </div>

      <v-row
        align="center"
        class="mx-0"
      >
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
            <v-icon
              v-else
            >mdi-heart</v-icon>
          </v-badge>
        </v-btn>

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
        <v-spacer></v-spacer>
        <router-link :to="{ name: 'HabitEdit' }">
          <v-btn
            v-if="isCurrentUser"
            text
            color="deep-purple accent-4"
            @click="setHabitDetail(habit.id)"
          >
            編集する
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
        'habit',
        'habitLocation',
      ]),

      isCurrentUser() {
        return this.habit.user_id === this.currentUser.id
      },
      likesCount() {
        return this.allFavorites.filter( favorite => favorite.habit_id === this.habit.id ).length
      },
      LikedUsers() {
        return this.allFavorites.filter( favorite => favorite.habit_id === this.habit.id).map( f => f.user_id )
      },
      isLike() {
        return this.LikedUsers.includes(this.currentUser.id)
      },
      favorites() {
        return this.allFavorites
      },
      currentUserGender() {
        return this.currentUser.gender
      },
      userGender() {
        if(this.habit.user_gender === 1) {
          return '(男性)'
        } else if(this.habit.user_gender === 2 ) {
          return '(女性)'
        } else {
          return ''
        }
      },
    },
    created() {
      const userId = this.currentUser.id
      this.setCurrentUserHabits(userId)
      this.setAllFavorites()
    },
    mounted() {
      this.loading = false

      const userId = this.currentUser.id
      axios
        .get(`/api/v1/users/${userId}.json`)
        .then(response => (this.user = response.data))
    },
    destroyed() {
      this.clearHabit()
    },
    methods: {
      ...mapActions ([
        'setAllFavorites',
        'setCurrentUserHabits',
        'addLike',
        'deleteLike',
        'clearHabit',
        'setHabitDetail'
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