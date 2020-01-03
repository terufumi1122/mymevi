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
        <!-- <Button
          buttonName="戻る"
        /> -->
        <v-spacer></v-spacer>
        <!-- <Button
          buttonName="リセット"
        /> -->
        <v-spacer></v-spacer>
        <!-- <Button
          buttonName="送信"
          @click="createUser"
        /> -->
        <v-btn @click="signInUser">ログイン</v-btn>
        <v-spacer></v-spacer>
        <v-btn @click="signOut">ログアウト</v-btn>
      </v-row>
      </v-form>
  </div>
</template>

<script>
  import axios from 'axios'

  export default {
    name: 'LoginForm',
    components: {
      // Button,
    },
    data() {
      return {
        valid: false,
        show1: false,
        radioGroup: 1,
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
    // computed: {
    //   user: {
    //     email: '',
    //     password: '',
    //   }
    // },
    methods: {
      signInUser() {
        const userParams = {
          "email": this.user.email,
          "password": this.user.password
        }
        this.$store.dispatch('signIn', userParams);
        // axios
        //   .post('/api/v1/auth/sign_in', this.user)
        //   .then(response => {
        //     let user = response.data;
        //     this.$store.state.headers = {
        //       "uid": response.headers['uid'],
        //       "access-token": response.headers['access-token'],
        //       "client": response.headers['client']
        //     };
        //     console.log(response.data);
        //     console.log(response.headers);
        //     console.log(this.$store.state.headers.uid);
        //     console.log(this.$store.state.headers.accessToken);
        //     console.log(this.$store.state.headers.client);
            this.$router.push({ name: 'Top' });
            // this.$router.push({ name: 'Top', params: { id: user.id } });
        //   })
        //   .catch(error => {
        //     console.error(error);
        //     if (error.response.data && error.response.data.errors) {
        //       this.errors = error.response.data.errors;
        //     }
        //   });
      },
      signOut() {
        this.$store.dispatch('signOut')
        this.$router.push({ name: 'Top'})
        // let headers = this.$store.state.headers
        // axios
        //   .delete('/api/v1/auth/sign_out',
        //           { headers: headers })
          // .catch(error => {
          //   console.error(error);
          //   if (error.response.data && error.response.data.errors) {
          //     this.errors = error.response.data.errors;
          //   }
          // });
      }
    }
  }
</script>

<style scoped>

</style>