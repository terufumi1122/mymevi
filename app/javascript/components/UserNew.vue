<template>
  <user-form-pane :errors="errors" :user="user" @submit="createUser"></user-form-pane>
</template>

<script>
import axios from 'axios';

import UserFormPane from "./UserFormPane.vue";

export default {
  name: 'UserNew',
  components: {
    UserFormPane,
  },
  data() {
    return {
      user: {
        name: '',
        email: '',
        age: '',
        gender: '',
      },
      errors: ''
    }
  },
  methods: {
    createUser: function() {
      axios
        .post('/api/v1/users', this.user)
        .then(response => {
          let user = response.data;
          this.$router.push({ name: 'UserDetail', params: { id: user.id} });
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  }
}
</script>