<template>
  <v-container>
    <div class="vertical-spacer"></div>
    <v-card
      class="mx-auto"
      max-width="344"
      outlined
    >
      <v-list-item three-line>

        <v-list-item-avatar
          circle
          size="130" 
          color="#990011"
        >
          <img
            v-if="user.image"
            :src="user.image"
            width="100" height="100" alt="プロフィール画像"
          />
          <img
            v-else
            src="../../assets/images/infinity.svg" width="100" height="100" alt="デフォルトプロフィール画像"
          />
        </v-list-item-avatar>
  
        <v-list-item-content>
          <div class="overline mb-4">About Me!</div>
          <v-list-item-title class="title mb-1">{{ user.name }}</v-list-item-title>
          <v-list-item-subtitle>E-mail: {{ user.email }}</v-list-item-subtitle>
          <v-list-item-subtitle>{{ user.birth_year }}年生まれ</v-list-item-subtitle>
          <v-list-item-subtitle>{{ userGender }}</v-list-item-subtitle>
        </v-list-item-content>

      </v-list-item>

      <v-card-actions>
        <v-btn
          text
          color="deep-purple accent-4"
          :to="{ name: 'UserImage' }"
        >画像を変更する</v-btn>
        <v-btn
          text
          color="deep-purple accent-4"
          :to="{ name: 'UserEdit' }"
        >登録情報を編集する</v-btn>
      </v-card-actions>
    </v-card>

    <div class="vertical-spacer"></div>

    <draggable v-model=habits>
      <div v-for="habit in habits" :key="habit.id">
        <BestItem
         :avatorColor="avatorColor[habit.best]"
         :habit="habit"
         :favorites="allFavorites"
         :isCurrentUser="habit.user_id === currentUser.id"
         >
        </BestItem>
        <div class="vertical-spacer"></div>
      </div>
    </draggable>

    <v-row>
      <v-spacer></v-spacer>
      <v-btn
        :to="{ name: 'HabitNew'}"
      >
        <v-icon>mdi-plus-box</v-icon>
        新規習慣の作成
      </v-btn>
      <v-spacer></v-spacer>
    </v-row>

    <div class="vertical-spacer"></div>
  </v-container>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex';
import axios from 'axios';
import BestItem from './BestItem';
import draggable from 'vuedraggable'


export default {
  name: 'UserDetail',
  components: {
    BestItem,
    draggable,
  },
  data() {
    return {
      avatorColor: {
        1: 'yellow',
        2: 'grey lighten-2',
        3: 'brown lighten-2'
      },
    }
  },
  computed:{
    ...mapGetters({
      getHabits: 'habits',
      allFavorites: 'allFavorites',
      currentUser: 'currentUser',
      user: 'user'
    }),
    habits: {
      get() {
        return this.getHabits
      },
      set(value) {
        this.setHabits(value)
        this.changeBest()
      }
    },
    userGender() {
      if(this.currentUser.gender === 1) {
        return '男性'
      } else if(this.currentUser.gender === 2 ) {
        return '女性'
      } else {
        return ''
      }
    },
  },
  created() {
    this.setCurrentUserHabits(this.currentUser.id)
    this.setAllHabits()
    this.setAllFavorites()
  },
  mounted() {
    axios
      .get(`/api/v1/users/${this.currentUser.id}.json`)
      .then(response => { this.setUser(response.data) })
  },
  methods: {
    ...mapMutations({
      setHabits: 'habits',
    }),
    ...mapActions({
      setAllFavorites: 'setAllFavorites',
      setAllHabits: 'setAllHabits',
      setCurrentUserHabits: 'setCurrentUserHabits',
      changeBest: 'changeBest',
      setUser: 'setUser',
    }),
    
  }
}
</script>

<style scoped>
.vertical-spacer {
  margin-top: 10px;
  margin-bottom: 10px;
}
</style>