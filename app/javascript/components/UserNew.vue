<template>
  <form @submit.prevent="createUser">
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li><font color="red">{{ e }}</font></li>
      </ul>
    </div>
    <div>
      <label>Name</label>
      <input v-model="user.name" type="text">
    </div>
    <div>
      <label>Email</label>
      <input v-model="user.email" type="email">
    </div>
    <div>
      <label>Age</label>
      <input v-model="user.age" type="integer">
    </div>
    <div>
      <label>Gender</label>
      <select v-model="user.gender">
        <option>other</option>
        <option>male</option>
        <option>female</option>
      </select>
    </div>
    <button type="submit">Commit</button>
  </form>
</template>

<script>
import axios from 'axios';

export default {
  name: 'UserNew',
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