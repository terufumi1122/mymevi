<template>
  <table>
    <tbody>
      <tr>
        <th>ID</th>
        <th>name</th>
        <th>email</th>
        <th>age</th>
        <th>gender</th>
      </tr>
      <tr v-for="user in users" :key="user.id">
        <td>{{ user.id }}</td>
        <td>{{ user.name }}</td>
        <td>{{ user.email }}</td>
        <td>{{ user.age }}</td>
        <td>{{ user.gender }}</td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import axios from 'axios';

export default {
  name: 'UsersIndex',
  data() {
    return {
      users: []
    }
  },
  mounted() {
    axios
      .get('/api/v1/users.json')
      .then(response => (this.users = response.data))
  }
}
</script>

