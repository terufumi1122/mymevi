<template>
  <div>
    <v-form>
      <v-container>
        <h2>新規習慣登録</h2>
        <v-row>
          <v-col
            cols="12"
            md="4"
          >
            <v-text-field
              v-model="habit.name"
              :rules="nameRules"
              :counter="20"
              label="習慣名"
              required
            ></v-text-field>
          </v-col>
          <v-col
            cols="12"
            md="4"
          >
            <v-text-field
              v-model="habit.description"
              :rules="descriptionRules"
              :counter="140"
              label="習慣詳細"
              required
            ></v-text-field>
          </v-col>
          <v-col
            cols="12"
            md="4"
          >
            <v-select
              v-model="habit.best"
              :items=items
              label="自分の中の習慣ランキング"
              required
            ></v-select>
          </v-col>
        </v-row>
      </v-container>
      <v-row>
        <v-spacer></v-spacer>
        <v-btn @click="addHabit1"><v-icon>mdi-plus-box</v-icon>登録する</v-btn>
        <v-spacer></v-spacer>
      </v-row>
    </v-form>
  </div>
</template>


<script>
import { mapGetters, mapActions } from 'vuex';

import axios from 'axios';

  const maxHabitAmount= 3;
  const habitAmount = Array.from(Array(maxHabitAmount).keys(), x => x + 1)

  export default {
    name: 'HabitNew',
    data() {
      return {
        habit: {},
        items: habitAmount,
        nameRules: [
          v => !!v || '習慣名の入力は必須です',
          v => v.length <= 20 || '習慣名は20文字以内で入力して下さい'
        ],
        descriptionRules: [
          v => v.length <= 140 || '習慣の詳細は140文字以下で入力して下さい',
        ],
      }
    },
    computed: {
      ...mapGetters([
        'currentUser'
      ]),
    },
    methods: {
      ...mapActions([
        'addHabit',
        'createFlash'
      ]),
      addHabit1() {
        // axiosを使ってRails APIを叩く。引数にhabitParamsを渡す。
        // 渡したhabitParamsをRails側で読み取り、DBに保存する。
        const habitParams = {
            "name": this.habit.name,
            "description": this.habit.description,
            "best": this.habit.best,
            "user_id": this.currentUser.data.id
        }
        this.addHabit(habitParams)
        this.$router.push({ name: 'Top' })
        this.createFlash({
          type: 'success',
          message: '新しい習慣を登録しました'
        })
      }
    }
  }
</script>