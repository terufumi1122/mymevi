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
          <v-list-item-subtitle>{{ user.age }} 歳</v-list-item-subtitle>
          <v-list-item-subtitle>{{ user.gender }}</v-list-item-subtitle>
        </v-list-item-content>

      </v-list-item>

      <v-card-actions>
        <v-btn text><router-link :to="{ name: 'UserEdit' }">編集する</router-link></v-btn>
      </v-card-actions>
    </v-card>

    <div class="vertical-spacer"></div>

    <div v-for="(habit, index) in habits" :key="habit.id">
      <BestItem v-if="index === 0" :avatorColor="avatorColor1" :habitNumber="index + 1" :habitTitle="habit.name" :userName="user.name"></BestItem>
      <BestItem v-else-if="index === 1" :avatorColor="avatorColor2" :habitNumber="index + 1" :habitTitle="habit.name" :userName="user.name"></BestItem>
      <BestItem v-else-if="index === 2" :avatorColor="avatorColor3" :habitNumber="index + 1" :habitTitle="habit.name" :userName="user.name"></BestItem>
      <BestItem v-else :avatorColor="avatorColor" :habitNumber="index + 1" :habitTitle="habit.name" :userName="user.name"></BestItem>
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
      avatorColor: 'white',
      avatorColor1: 'yellow',
      avatorColor2: 'grey lighten-2',
      avatorColor3: 'brown lighten-2',
      user: {
        name: '',
        email: '',
        age: '',
        gender: ''
      }
    }
  },
  computed:{
    habits() {
      return this.$store.getters.habits
    }
  },
  created() {
    const userId = this.$store.state.currentUser.data.id
    this.$store.dispatch('setCurrentUserHabits', userId)
  },
  mounted() {
    const userId = this.$store.state.currentUser.data.id
    axios
      .get(`/api/v1/users/${userId}.json`)
      .then(response => (this.user = response.data))
  }
}
</script>

<style scoped>
.vertical-spacer {
  margin-top: 10px;
  margin-bottom: 10px;
}
</style>