<template>
  <div>
    <dl>
      <dt>Name</dt>
      <dd>{{ user.name }}</dd>
      <dt>Email</dt>
      <dd>{{ user.email }}</dd>
      <dt>Age</dt>
      <dd>{{ user.age }}</dd>
      <dt>Gender</dt>
      <dd>{{ user.gender }}</dd>
    </dl>
    <router-link :to="{ name: 'UsersIndex' }">UsersIndexへ</router-link>
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

