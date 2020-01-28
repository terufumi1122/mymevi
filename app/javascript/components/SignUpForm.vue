<template>
  <div>
    <user-form formTitle="新規ユーザー登録" :errors="errors" :user="user" @clickButton="createUser">新規ユーザー登録</user-form>
  </div>
</template>

<script>
  import { mapActions } from 'vuex'

  import axios from 'axios'

  import UserForm from "./UserForm.vue"

  export default {
    name: 'SignUpForm',
    components: {
      UserForm,
    },
    data() {
      return {
        errors: '',
        user: {}
      }
    },
    methods: {
      ...mapActions([
        'signUp',
      ]),
      createUser: function() {
        const userParams = {
          "name": this.user.name,
          "email": this.user.email,
          "birth_year": this.user.birth_year,
          "birth_month": this.user.birth_month,
          "birth_day": this.user.birth_day,
          "gender": this.user.gender,
          "password": this.user.password,
          "password_confirmation": this.user.password_confirmation,
        }
        this.signUp(userParams, this.routeTo('Top'))
      },
      routeTo(routeName) {
        this.$router.push({name: routeName})
      }
    }
  }
</script>