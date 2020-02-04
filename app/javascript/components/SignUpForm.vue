<template>
  <div>
    <UserForm
      mode="full"
      formTitle="新規ユーザー登録"
      :user="user"
      @clickButton="createUser"
      >新規ユーザー登録</UserForm>
  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'

  import axios from 'axios'

  import UserForm from "./UserForm.vue"

  export default {
    name: 'SignUpForm',
    components: {
      UserForm,
    },
    computed: {
      ...mapGetters([
        'user'
      ])
    },
    methods: {
      ...mapActions([
        'signUp',
      ]),
      createUser: function() {
        const userParams = {
          name: this.user.name,
          email: this.user.email,
          birth_year: this.user.birth_year,
          birth_month: this.user.birth_month,
          birth_day: this.user.birth_day,
          gender: this.user.gender,
          password: this.user.password,
          password_confirmation: this.user.password_confirmation,
          image: this.user.image
        }
        this.signUp(userParams, this.routeTo('Top'))
      },
      routeTo(routeName) {
        this.$router.push({name: routeName})
      }
    }
  }
</script>