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
          <img src="../../assets/images/infinity.svg" width="100" height="100" alt="プロフィール画像">
        </v-list-item-avatar>
  
        <v-list-item-content>
          <div class="overline mb-4">About Me!</div>
          <v-list-item-title class="headline mb-1">{{ user.name }}</v-list-item-title>
          <v-list-item-subtitle>E-mail: {{ user.email }}</v-list-item-subtitle>
          <v-list-item-subtitle>{{ user.birth_year }}年生まれ</v-list-item-subtitle>
          <v-list-item-subtitle>{{ userGender }}</v-list-item-subtitle>
        </v-list-item-content>

      </v-list-item>

      <v-card-actions>
        <v-btn text><router-link :to="{ name: 'UserEdit' }">編集する</router-link></v-btn>
      </v-card-actions>
    </v-card>

    <div class="vertical-spacer"></div>

    <div v-for="habit in habits" :key="habit.id">
      <BestItem
       :avatorColor="avatorColor[habit.best]"
       :habitNumber="habit.best"
       :habitTitle="habit.name"
       :userName="habit.user_name + 'さんのベスト' + habit.best + '位の習慣です！'"

       :habitId="habit.id"
       :userId="currentUser.id"
       :favorites="allFavorites"
       :isCurrentUser="habit.user_id === currentUser.id"
       />
      <div class="vertical-spacer"></div>
    </div>

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
import { mapGetters, mapActions } from 'vuex';
import axios from 'axios';
import BestItem from './BestItem';

export default {
  name: 'UserDetail',
  components: {
    BestItem,
  },
  data() {
    return {
      avatorColor: {
        1: 'yellow',
        2: 'grey lighten-2',
        3: 'brown lighten-2'
      },
      user: {}
    }
  },
  computed:{
    ...mapGetters([
      'habits',
      'allFavorites',
      'currentUser',
    ]),
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
    const userId = this.currentUser.id
    this.setCurrentUserHabits(userId)
    this.setAllHabits()
    this.setAllFavorites()
  },
  mounted() {
    axios
      .get(`/api/v1/users/${this.currentUser.id}.json`)
      .then(response => (this.user = response.data))
  },
  methods: {
    ...mapActions([
      'setAllFavorites',
      'setAllHabits',
      'setCurrentUserHabits',
    ]),
    
  }
}
</script>

<style scoped>
.vertical-spacer {
  margin-top: 10px;
  margin-bottom: 10px;
}
</style>