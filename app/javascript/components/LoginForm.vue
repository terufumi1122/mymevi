<template>
  <div>
    <UserForm
      mode="login"
      formTitle="ログイン"
      :user="user"
      @clickButton="signInUser"
    >ログイン</UserForm>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';

import UserForm from './UserForm'

  export default {
    name: 'LoginForm',
    components: {
      UserForm
    },
    computed: {
      ...mapGetters([
        'currentUser',
        'user'
      ])
    },
    methods: {
      ...mapActions([
        'signIn',
      ]),
      signInUser() {
        const userParams = {
          "email": this.user.email,
          "password": this.user.password
        }
        this.signIn(userParams, this.routeTo('Top'))
      },
      routeTo(routeName) {
        this.$router.push({ name: routeName })
      },
    }
  }
</script>

<style scoped>

</style>