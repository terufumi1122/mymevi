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

      <v-card-title>{{ habitDetail.name }}</v-card-title>

      <v-card-text>
        <div>詳細：{{ habitDetail.description }}</div>
        <div>場所：{{ habitLocation.name }}</div>
      </v-card-text>

      <v-divider class="mx-4"></v-divider>

      <v-card-title>こんな人がオススメしています！</v-card-title>

      <div class="my-4 subtitle-1 grey--text">
        {{ habitDetail.user_name }}{{ userGender }}さんの{{ habitDetail.best }}番目のオススメ習慣です！
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
        'habitDetail',
        'habitLocation'
      ]),

      isCurrentUser() {
        return this.habitDetail.user_id === this.currentUser.id
      },
      likesCount() {
        return this.allFavorites.filter( favorite => favorite.habit_id === this.habitDetail.id ).length
      },
      LikedUsers() {
        return this.allFavorites.filter( favorite => favorite.habit_id === this.habitDetail.id).map( f => f.user_id )
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
        if(this.habitDetail.user_gender === 1) {
          return '(男性)'
        } else if(this.habitDetail.user_gender === 2 ) {
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
    methods: {
      ...mapActions ([
        'setAllFavorites',
        'setCurrentUserHabits',
        'addLike',
        'deleteLike',
        'setCurrentHabit'
      ]),
      toggleLike() {
        let likeParams = {user_id: this.currentUser.id, habit_id: this.habitDetail.id}
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