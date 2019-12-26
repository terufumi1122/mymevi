<template>
  <div>
    <router-link :to="{ name: 'UserNew' }">新規ユーザー作成</router-link>
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
          <td><router-link :to="{ name: 'UserDetail', params: { id: user.id } }">{{ user.id }}</router-link></td>
          <td>{{ user.name }}</td>
          <td>{{ user.email }}</td>
          <td>{{ user.age }}</td>
          <td>{{ user.gender }}</td>
          <td><router-link :to="{ name: 'UserEdit', params: { id: user.id } }">Edit</router-link></td>
        </tr>
      </tbody>
    </table>
  </div>
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

