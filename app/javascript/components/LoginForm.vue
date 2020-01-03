<template>
  <div>
    <v-form>
      <v-container>
        <v-row>
          <v-col
            cols="12"
            md="4"
          >
            <v-text-field
              v-model="user.email"
              :rules="emailRules"
              label="メールアドレス"
              required
            ></v-text-field>
          </v-col>
          <v-col
            cols="12"
            md="4"
          >
            <v-text-field
              v-model="user.password"
              :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              :rules="passwordRules"
              :type="show1 ? 'text' : 'password'"
              :counter="16"
              label="パスワード"
              required
              @click:append="show1 = !show1"
            ></v-text-field>
          </v-col>
        </v-row>
      </v-container>
      <v-row>
        <v-spacer></v-spacer>
        <v-btn @click="signInUser">ログイン</v-btn>
        <v-spacer></v-spacer>
        <v-btn @click="signOut">ログアウト</v-btn>
        <v-spacer></v-spacer>
      </v-row>
      </v-form>
  </div>
</template>

<script>
  import axios from 'axios'

  export default {
    name: 'LoginForm',
    data() {
      return {
        valid: false,
        show1: false,
        radioGroup: 1,
        errors: '',
        user: {
          email: '',
          password: '',
        },
        emailRules: [
          v => !!v || 'メールアドレスの入力は必須です',
          v => /.+@.+/.test(v) || '有効なメールアドレスを入力して下さい'
        ],
        passwordRules: [
          v => !!v || 'パスワードの入力は必須です',
          v => v.length >= 8 || 'パスワードは8文字以上16文字以内で入力して下さい',
          v => v.length <= 16 || 'パスワードは8文字以上16文字以内で入力して下さい'
        ],
      }
    },
    methods: {
      signInUser() {
        const userParams = {
          "email": this.user.email,
          "password": this.user.password
        }
        this.$store.dispatch('signIn', userParams);
        this.$router.push({ name: 'Top' });
      },
      signOut() {
        this.$store.dispatch('signOut')
        this.$router.push({ name: 'Top'})
      }
    }
  }
</script>

<style scoped>

</style>