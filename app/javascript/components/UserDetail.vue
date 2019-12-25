<template>
  <dl>
    <dt>ID</dt>
    <dd>{{ user.id }}</dd>
    <dt>Name</dt>
    <dd>{{ user.name }}</dd>
    <dt>Email</dt>
    <dd>{{ user.email }}</dd>
    <dt>Age</dt>
    <dd>{{ user.age }}</dd>
    <dt>Gender</dt>
    <dd>{{ user.gender }}</dd>
  </dl>
</template>

<script>
import axios from 'axios';

export default {
  name: 'UserDetail',
  data() {
    return {
      user: {}
    }
  },
  mounted() {
    axios
      .get(`/api/v1/users/${this.$route.params.id}.json`)
      .then(response => (this.user = response.data))
  }
}
</script>

