<template>
  <div>
    <user-form formTitle="ユーザー情報の変更" :errors="errors" :user="user" @clickButton="updateUser">入力の通りに更新する</user-form>
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
      errors: '',
    }
  },
  mounted() {
    // axios
    //   .get(`/api/v1/users/${this.$route.params.id}.json`)
    //   .then(response => (this.user = response.data))
  },
  methods: {
    updateUser: function() {
      const userParams = {
        "name": this.user.name,
        "email": this.user.email,
        "age": this.user.age,
        "gender": this.user.gender,
        "password": this.user.password,
        "password_confirmation": this.user.password_confirmation,
      }
      this.$store.dispatch('updateUser', userParams)
      this.$router.push({ name: 'Top' });
    },
    // updateUser() {
    //   axios
    //     .put(`/api/v1/auth`, this.user)
    //     .then(response => {
    //       this.$router.push({ name: 'UserDetail' });
    //     })
    //     .catch(error => {
    //       console.error(error);
    //       if (error.response.data && error.response.data.errors) {
    //         this.errors = error.response.data.errors;
    //       }
    //     });
    // },
    deleteUser() {
      alert('これからアクションを実装して削除出来るようにします！')
    }
  }
}
</script>