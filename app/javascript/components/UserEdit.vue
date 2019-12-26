<template>
  <user-form-pane :errors="errors" :user="user" @submit="updateUser"></user-form-pane>
</template>

<script>
import axios from "axios";

import UserFormPane from "./UserFormPane.vue"

export default {
  components: {
    UserFormPane
  },
  data() {
    return {
      user: {},
      errors: ''
    }
  },
  mounted() {
    axios
      .get(`/api/v1/users/${this.$route.params.id}.json`)
      .then(response => (this.employee = response.data))
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
    }
  }
}
</script>