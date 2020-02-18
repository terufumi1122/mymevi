<template>
  <div>

    <v-card
      class="mx-auto my-12"
      max-width="374"
    >
      <v-img
        transition="false"
        haight="250"
        :src="habit.image"
        alt="登録した習慣の画像"
      ></v-img>

      <v-card-title>{{ habit.name }}</v-card-title>

      <v-card-text>
        <p>{{ habit.description }}</p>
      </v-card-text>

      <v-divider class="mx-4"></v-divider>

      <v-card-text class="grey--text">
        <p>{{ habit.user_name }}{{ userGender }}さんの{{ habit.best }}番目のイチオシ習慣です！</p>
        <p>{{ habitLocation.name }}</p>
      </v-card-text>

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
            <v-icon
              v-else
            >mdi-heart</v-icon>
          </v-badge>
        </v-btn>
          <v-btn
            color="deep-purple accent-4"
            text
            :to="{ name: 'AllBestHabits' }"
          >
            みんなの習慣一覧に戻る
          </v-btn>
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

      <Loading/>
    </v-card>

    <Comments></Comments>
    <CommentNew></CommentNew>

  </div>
</template>

<script>
  import { mapGetters, mapMutations, mapActions } from 'vuex'
  import axios from 'axios'
  import Loading from './Loading'
  import Comments from './Comments'
  import CommentNew from './CommentNew'

  export default {
    name: 'HabitDetail',
    components: {
      Loading,
      Comments,
      CommentNew,
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
      this.loadingTrue()
      const userId = this.currentUser.id
      this.setCurrentUserHabits(userId)
      this.setAllFavorites()
    },
    mounted() {
      const userId = this.currentUser.id
      axios
        .get(`/api/v1/users/${userId}.json`)
        .then(response => (this.user = response.data))
    },
    destroyed() {
      this.clearHabit()
    },
    methods: {
      ...mapMutations([
        'loadingTrue',
      ]),
      ...mapActions ([
        'setAllFavorites',
        'setCurrentUserHabits',
        'addLike',
        'deleteLike',
        'clearHabit',
        'setHabitDetail',
        'setComments',
        'setComment',
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