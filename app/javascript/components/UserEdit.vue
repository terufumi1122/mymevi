<template>
  <div>
    <user-form formTitle="ユーザー情報の変更" :errors="errors" :user="user" @clickButton="updateUser1">入力の通りに更新する</user-form>
    <Dialog @clickDialogButton="deleteUser1">
        <v-icon>mdi-trash-can</v-icon>
        アカウントを削除する
    </Dialog>
  </div>
</template>

<script>
import { mapMutations, mapActions } from 'vuex';

import axios from "axios";

import UserForm from "./UserForm.vue"
import Dialog from "./Dialog.vue"

export default {
  components: {
    UserForm,
    Dialog,
  },
  data() {
    return {
      user: {},
      errors: '',
    }
  },
  mounted() {
    // axios
    //   .get(`/api/v1/users/${this.$route.params.id}.json`)
    //   .then(response => (this.user = response.data))
  },
  methods: {
    ...mapMutations([
      'flashUpdateUser',
      'flashDeleteUser'
    ]),
    ...mapActions([
      'updateUser',
      'deleteUser'
    ]),
    updateUser1() {
      const userParams = {
        "name": this.user.name,
        "email": this.user.email,
        "age": this.user.age,
        "gender": this.user.gender,
        "password": this.user.password,
        "password_confirmation": this.user.password_confirmation,
      }
      this.updateUser(userParams)
      this.$router.push({ name: 'Top' })
      this.flashDeleteUser()
    },
    deleteUser1() {
      this.deleteUser()
      this.$router.push({ name: 'Top' })
      this.flashDeleteUser()
    }
  }
}
</script>