<template>
  <div>
    <UserForm
      mode="full"
      formTitle="ユーザー情報の変更"
      :errors="errors"
      :user="currentUser"
      @clickButton="updateUser1"
    >入力の通りに更新する</UserForm>
    <Dialog
      @clickDialogButton="deleteUser1"
    >
        <v-icon>mdi-trash-can</v-icon>
        アカウントを削除する
    </Dialog>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';

import axios from "axios";

import UserForm from "./UserForm.vue"
import Dialog from "./Dialog.vue"

export default {
  name: 'UserEdit',
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
  },
  methods: {
    ...mapActions([
      'updateUser',
      'deleteUser',
      'createFlash'
    ]),
    updateUser1() {
      const userParams = {
        "name": this.currentUser.name,
        "email": this.currentUser.email,
        "birth_year": this.currentUser.birth_year,
        "birth_month": this.currentUser.birth_month,
        "birth_day": this.currentUser.birth_day,
        "gender": this.currentUser.gender,
        "password": this.currentUser.password,
        "password_confirmation": this.currentUser.password_confirmation,
      }
      this.updateUser(userParams, this.routeTo('Top'))
    },
    deleteUser1() {
      if (this.sampleLogined === true) {
        this.createFlash({
          type: 'warning',
          message: 'ゲストユーザーを削除することは出来ません'
        })
      } else {
        this.deleteUser(this.routeTo('Top'))
      }
    },
    routeTo(routeName) {
      this.$router.push({ name: routeName })
    }
  }
}
</script>