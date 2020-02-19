<template>
    <v-container>
      <v-form>
        <h2>{{ formTitle }}</h2>
        <div v-if="mode === 'full'">
          <v-row>
              <v-text-field
                class="mx-3"
                :value="user.name"
                @input="updateUserParams($event, 'name')"
                :rules="nameRules"
                :counter="20"
                label="ニックネーム"
                required
              ></v-text-field>
          </v-row>
        </div>
        <v-row>
            <v-text-field
              class="mx-3"
              :value="user.email"
              @input="updateUserParams($event, 'email')"
              :rules="emailRules"
              label="メールアドレス"
              required
            ></v-text-field>
        </v-row>
        <div v-if="mode === 'full'">
          <v-row>
              <v-select
                class="mx-3"
                :value="user.birth_year"
                @input="updateUserParams($event, 'birth_year')"
                :items="years"
                label="誕生年（西暦）"
              ></v-select>
          </v-row>
          <v-row>
            <v-radio-group
              class="mx-3"
              label="性別"
              :value="user.gender"
              @change="updateUserParams($event, 'gender')"
              row
            >
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
          </v-row>
        </div>
        <v-row>
            <v-text-field
              class="mx-3"
              :value="user.password"
              @input="updateUserParams($event, 'password')"
              :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              :rules="passwordRules"
              :type="show1 ? 'text' : 'password'"
              :counter="16"
              label="パスワード"
              required
              @click:append="show1 = !show1"
            ></v-text-field>
        </v-row>
        <div v-if="mode === 'full'">
          <v-row>
              <v-text-field
                class="mx-3"
                :value="user.password_confirmation"
                @input="updateUserParams($event, 'password_confirmation')"
                :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
                :rules="passwordRules"
                :type="show2 ? 'text' : 'password'"
                :counter="16"
                label="パスワード(確認用)"
                required
                @click:append="show2 = !show2"
              ></v-text-field>
          </v-row>
        </div>

        <v-row>
          <v-spacer></v-spacer>
          <v-btn
          color="green"
          dark
          @click="$emit('clickButton')"
          >
            <slot>初期値だよー。</slot>
          </v-btn>
          <v-spacer></v-spacer>
        </v-row>
      </v-form>
    </v-container>
</template>

<script>
  import { mapActions } from 'vuex'

  const year = new Date().getFullYear()
  const maxAge = 117 //ギネス世界記録の最高齢

  const start = year - maxAge
  const end = year

  const years = [...Array(end - start + 1).keys()].map( i => start + i)
  const yearRange = years.sort((a,b) => {
    return (a < b ? 1 : -1)
  })

  export default {
    name: 'UserForm',
    props: {
      formTitle: String,
      user: Object,
      mode: String,
      showImageForm: Boolean,
    },
    data() {
      return {
        valid: false,
        show1: false,
        show2: false,
        radioGroup: 1,
        years: yearRange,
        nameRules: [
          v => !!v || 'ニックネームの入力は必須です',
          v => v.length < 20 || 'ニックネームは20文字以内で入力して下さい'
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
    destroyed() {
      this.clearUser()
    },
    methods: {
      ...mapActions ([
        'clearUser'
      ]),
      updateUserParams(event,keyName) {
        this.$store.commit('updateUserParams', { value: event, keyName })
      }
    }
  }
</script>