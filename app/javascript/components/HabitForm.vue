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
        <v-btn
          :color="buttonColor"
          dark
          @click="$emit('clickButton')"
        >
          <v-icon>mdi-plus-box</v-icon>
          {{ buttonName }}
        </v-btn>
        <v-spacer></v-spacer>
        <v-btn
          color="red"
          dark
          @click="destroy"
        >
          <v-icon>mdi-delete</v-icon>
          削除する
        </v-btn>
        <v-spacer></v-spacer>
      </v-row>
    </v-form>
  </div>
</template>


<script>
import { mapActions } from 'vuex';

  const maxHabitAmount= 3;
  const habitAmount = Array.from(Array(maxHabitAmount).keys(), x => x + 1)

  export default {
    name: 'HabitForm',
    props: {
      formTitle: '',
      buttonName: '',
      habit: {},
      buttonColor: '',
      clickButton: '',
    },
    data() {
      return {
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
    methods: {
      ...mapActions([
        'destroyHabit'
      ]),
      destroy() {
        this.destroyHabit(this.habit.id, this.$router.push({name: 'Top'}))
      }
    }
  }
</script>