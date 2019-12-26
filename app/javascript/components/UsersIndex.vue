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
          <td>
            <button @click="deleteTarget = user.id; showModal = true">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
    <modal v-if="showModal" @cancel="showModal = false" @ok="deleteUser(); showModal = false;">
      <div slot="body">Are you sure?</div>
    </modal>
  </div>
</template>

<script>
import axios from 'axios';

import Modal from './Modal.vue'

export default {
  name: 'UsersIndex',
  components: {
    Modal
  },
  data() {
    return {
      users: [],
      showModal: false,
      deleteTarget: -1,
      errors: ''
    }
  },
  mounted() {
    this.updateUsers();
  },
  methods: {
    deleteUser() {
      if (this.deleteTarget <= 0) {
        console.warn('deleteTarget should be grater than zero.');
        return;
      }
    axios
      .delete(`/api/v1/users/${this.deleteTarget}`)
      .then(response => {
        this.deleteTarget = -1;
        this.updateUsers();
      })
      .catch(error => {
        console.error(error);
        if (error.response.data && error.response.data.errors) {
          this.errors = error.response.data.errors;
        }
      });
    },
    updateUsers() {
      axios
        .get('/api/v1/users.json')
        .then(response => (this.users = response.data))
    }
  }
}
</script>

