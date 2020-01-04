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
        <v-btn text><router-link :to="{ name: 'UserEdit' }">編集</router-link></v-btn>
        <v-btn text>削除</v-btn>
      </v-card-actions>
    </v-card>
    <div class="vertical-spacer"></div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'UserDetail',
  data() {
    return {
      user: {
        name: '',
        email: '',
        age: '',
        gender: ''
      }
    }
  },
  mounted() {
    const userId = this.$store.state.currentUser.data.id
    axios
      .get(`/api/v1/users/${userId}.json`)
      .then(response => (this.user = response.data))
    // this.user.name = this.$store.state.currentUser.data.name;
    // this.user.email = this.$store.state.currentUser.data.email;
    // this.user.age = this.$store.state.currentUser.data.age;
    // this.user.gender = this.$store.state.currentUser.data.gender;
  }
}
</script>

<style scoped>
.vertical-spacer {
  margin-top: 10px;
  margin-bottom: 10px;
}
</style>