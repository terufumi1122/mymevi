<template>
  <div>
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
          color="red"
        ></v-list-item-avatar>
  
        <v-list-item-content>
          <div class="overline mb-4">About Me!</div>
          <v-list-item-title class="headline mb-1">{{ user.name }}</v-list-item-title>
          <v-list-item-subtitle>E-mail: {{ user.email }}</v-list-item-subtitle>
          <v-list-item-subtitle>{{ user.birthday }}生まれ</v-list-item-subtitle>
          <!-- <v-list-item-subtitle>{{ user.gender }}</v-list-item-subtitle> -->
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
       :userId="currentUser.data.id"
       :favorites="favorites"
       :isDisabled="habit.user_id === currentUser.data.id"
       />
      <div class="vertical-spacer"></div>
    </div>

    <v-row>
      <v-spacer></v-spacer>
      <v-btn>
        <router-link :to="{ name: 'HabitNew' }"><v-icon>mdi-plus-box</v-icon>新規習慣の作成</router-link>
      </v-btn>
      <v-spacer></v-spacer>
    </v-row>

    <div class="vertical-spacer"></div>
  </div>
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
      userName: '',
      avatorColor: {
        1: 'yellow',
        2: 'grey lighten-2',
        3: 'brown lighten-2'
      },
      user: {
        name: '',
        email: '',
        birthday: '',
        gender: ''
      }
    }
  },
  computed:{
    ...mapGetters([
      'habits',
      'allFavorites',
      'currentUser',
    ]),
    userGender() {
      if(this.currentUserGender === 1) {
        return '男性'
      } else if(this.currentUserGender === 2 ) {
        return '女性'
      } else {
        return ''
      }
    },
    favorites() {
      return this.allFavorites
    },
    currentUserGender() {
      return this.currentUser.data.gender
    }
  },
  created() {
    const userId = this.currentUser.data.id
    this.setCurrentUserHabits(userId)
    this.setAllFavorites()
  },
  mounted() {
    const userId = this.currentUser.data.id
    axios
      .get(`/api/v1/users/${userId}.json`)
      .then(response => (this.user = response.data))
  },
  methods: {
    ...mapActions([
      'setAllFavorites',
      'setCurrentUserHabits'
    ])
  }
}
</script>

<style scoped>
.vertical-spacer {
  margin-top: 10px;
  margin-bottom: 10px;
}
</style>