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
              v-model="name"
              :rules="nameRules"
              :counter="20"
              label="名前"
              required
            ></v-text-field>
          </v-col>
          <v-col
            cols="12"
            md="4"
          >
            <v-text-field
              v-model="email"
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
              v-model="password"
              :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              :rules="passwordRules"
              :type="show1 ? 'text' : 'password'"
              :counter="16"
              label="パスワード"
              required
              @click:append="show1 = !show1"
            ></v-text-field>
          </v-col>
          <v-col
            cols="12"
            md="4"
          >
            <v-text-field
              v-model="password_confirmation"
              :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
              :rules="passwordRules"
              :type="show2 ? 'text' : 'password'"
              :counter="16"
              label="パスワード(確認用)"
              required
              @click:append="show2 = !show2"
            ></v-text-field>
          </v-col>
        </v-row>
      </v-container>
    </v-form>
    <v-row>
      <v-spacer></v-spacer>
      <Button
        buttonName="戻る"
      />
      <v-spacer></v-spacer>
      <Button
        buttonName="リセット"
      />
      <v-spacer></v-spacer>
      <Button
        buttonName="送信"
      />
      <v-spacer></v-spacer>
    </v-row>
  </div>
</template>

<script>
  import Button from './Button'

  export default {
    name: 'LoginForm',
    components: {
      Button,
    },
    data() {
      return {
        valid: false,
        show1: false,
        show2: false,
        name: '',
        nameRules: [
          v => !!v || '名前の入力は必須です',
          v => v.length <= 10 || '名前は20文字以内で入力して下さい'
        ],
        email: '',
        emailRules: [
          v => !!v || 'メールアドレスの入力は必須です',
          v => /.+@.+/.test(v) || '有効なメールアドレスを入力して下さい'
        ],
        password: '',
        password_confirmation: '',
        passwordRules: [
          v => !!v || 'パスワードの入力は必須です',
          v => v.length >= 8 || 'パスワードは8文字以上16文字以内で入力して下さい',
          v => v.length <= 16 || 'パスワードは8文字以上16文字以内で入力して下さい'
        ],
      }
    },
  }
</script>

<style scoped>

</style>