<template>
  <div>
    <v-form>
      <v-container>
        <h2>{{ formTitle }}</h2>
        <v-row>
          <v-col
            cols="12"
            md="4"
          >
            <v-text-field
              v-model="user.name"
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
            <v-select
              v-model="user.age"
              :items="items"
              label="年齢"
            ></v-select>
          </v-col>
          <v-col
            cols="12"
            md="4"
          >
          <v-radio-group label="性別" v-model="user.gender" row>
            <v-radio
              :label="`男性`"
              :value="1"
            ></v-radio>
            <v-radio
              :label="`女性`"
              :value="2"
            ></v-radio>
            <v-radio
              :label="`その他`"
              :value="3"
            ></v-radio>
          </v-radio-group>
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
          <v-col
            cols="12"
            md="4"
          >
            <v-text-field
              v-model="user.password_confirmation"
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
      <v-row>
        <v-spacer></v-spacer>
        <v-btn @click="$emit('clickButton')"><slot>初期値だよー。</slot></v-btn>
        <v-spacer></v-spacer>
      </v-row>
    </v-form>
  </div>
</template>

<script>
  const maxAge = 117;
  const ageRange = [...Array(maxAge).keys()]

  export default {
    name: 'UserForm',
    props: {
      formTitle: '',
      user: {},
    },
    data() {
      return {
        valid: false,
        show1: false,
        show2: false,
        radioGroup: 1,
        items: ageRange,
        nameRules: [
          v => !!v || '名前の入力は必須です',
          v => v.length <= 10 || '名前は20文字以内で入力して下さい'
        ],
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
  }
</script>