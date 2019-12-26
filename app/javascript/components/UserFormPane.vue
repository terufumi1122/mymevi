<template>
  <form @submit.prevent="$emit('submit')">
    <div v-if="errors.length != 0">
      <ul v-for="error in errors" :key="e">
        <li><font color="red">{{ error }}</font></li>
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
        <option>Other</option>
        <option>male</option>
        <option>female</option>
      </select>
    </div>
    <button type="submit">Commit</button>
  </form>
</template>

<script>
export default {
  props: {
    user: {},
    errors: ''
  }
}
</script>