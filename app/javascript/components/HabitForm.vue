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
        <v-btn @click="clickButton"><v-icon>mdi-plus-box</v-icon>{{ buttonName }}</v-btn>
        <v-spacer></v-spacer>
      </v-row>
    </v-form>
  </div>
</template>


<script>
import { mapGetters, mapActions } from 'vuex';

  const maxHabitAmount= 3;
  const habitAmount = Array.from(Array(maxHabitAmount).keys(), x => x + 1)

  export default {
    name: 'HabitForm',
    props: {
      formTitle: '',
      buttonName: '',
      habit: {},
    },
    data() {
      return {
        // habit: {},
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
        'updateHabit',
      ]),
      clickButton() {
        const habitParams = {
            "name": this.habit.name,
            "description": this.habit.description,
            "best": this.habit.best,
            "user_id": this.currentUser.id
        }
        if (this.buttonName === '新しい習慣を登録する') {
          this.addHabit(habitParams, this.routeTo('Top'))
        } else if (this.buttonName === '上記内容で修正する') {
          this.updateHabit(habitParams, this.routeTo('Top'))
        }
      },
      routeTo(routeName) {
        this.$router.push({ name: routeName })
      }
    }
  }
</script>