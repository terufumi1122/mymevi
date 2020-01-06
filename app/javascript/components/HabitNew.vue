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
              v-model="habit.email"
              :rules="descriptionRules"
              label="習慣詳細"
              required
            ></v-text-field>
          </v-col>
        </v-row>
      </v-container>
      <v-row>
        <v-spacer></v-spacer>
        <v-btn><v-icon>mdi-plus-box</v-icon>登録する</v-btn>
        <v-spacer></v-spacer>
      </v-row>
    </v-form>
  </div>
</template>


<script>
  export default {
    name: 'HabitNew',
    data() {
      return {
        habit: {},
        nameRules: [
          v => !!v || '習慣名の入力は必須です',
          v => v.length <= 20 || '習慣名は20文字以内で入力して下さい'
        ],
        descriptionRules: [
          v => v.length <= 140 || '習慣の詳細は140文字以下で入力して下さい',
        ],
      }
    },
  }
</script>