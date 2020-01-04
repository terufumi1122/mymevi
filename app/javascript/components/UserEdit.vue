<template>
  <div>
    <user-form :errors="errors" :user="user" @submit="updateUser"></user-form>
    <v-btn
      icon
      @click="deleteUser"
    >
      <v-icon>mdi-trash-can</v-icon>
    </v-btn>
  </div>
</template>

<script>
import axios from "axios";

import UserForm from "./UserForm.vue"

export default {
  components: {
    UserForm
  },
  data() {
    return {
      user: {},
      errors: ''
    }
  },
  mounted() {
    // axios
    //   .get(`/api/v1/users/${this.$route.params.id}.json`)
    //   .then(response => (this.user = response.data))
  },
  methods: {
    updateUser() {
      axios
        .patch(`/api/v1/users/${this.user.id}`, this.user)
        .then(response => {
          this.$router.push({ name: 'UserDetail', params: { id: this.user.id } });
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    deleteUser() {
      alert('これからアクションを実装して削除出来るようにします！')
    }
  }
}
</script>