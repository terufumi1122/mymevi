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
import { mapGetters, mapMutations, mapActions } from 'vuex';

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
      errors: '',
    }
  },
  computed: {
    ...mapGetters([
      'currentUser',
      'sampleLogined'
    ]),
    user() {
      return this.currentUser.data
    }
  },
  methods: {
    ...mapMutations([
      'flashUpdateUser',
      'flashDeleteUser'
    ]),
    ...mapActions([
      'updateUser',
      'deleteUser',
      'flashCantDelete'
    ]),
    updateUser1() {
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
      this.updateUser(userParams)
      this.$router.push({ name: 'Top' })
      this.flashUpdateUser()
    },
    deleteUser1() {
      if (this.sampleLogined === true) {
        this.flashCantDelete()
      } else {
        this.deleteUser()
        this.$router.push({ name: 'Top' })
        this.flashDeleteUser()
      }
    }
  }
}
</script>