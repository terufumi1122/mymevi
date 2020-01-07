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
    <BestItem habitNumber="123" habitTitle="タイトルサンプル" :userName="user.name"></BestItem>
    <BestItem habitNumber="1" :habitTitle="habitName[0].name" :userName="user.name"></BestItem>
    <p>この下にマイ習慣があるだけ表示される</p>

    <v-btn text>
      <router-link :to="{ name: 'HabitNew' }">新規習慣 作成ボタン(HabitNew.vueへリンク)</router-link>
      </v-btn>
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
      habitTitle: '',
      user: {
        name: '',
        email: '',
        age: '',
        gender: ''
      }
    }
  },
  computed:{
    habitName() {
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