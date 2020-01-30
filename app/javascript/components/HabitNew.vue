<template>
  <div>
    <HabitForm
      formTitle="新規習慣登録"
      buttonName="新しい習慣を登録する"
      :habit="habit"
      buttonColor="blue"
      @clickButton="newHabit"
    ></HabitForm>
  </div>
</template>


<script>
import { mapGetters, mapActions } from 'vuex'
import HabitForm from './HabitForm.vue'

  export default {
    name: 'HabitNew',
    components: {
      HabitForm,
    },
    data() {
      return {
        habit: {},
      }
    },
    computed: {
      ...mapGetters([
        'currentUser'
      ])
    },
    methods: {
      ...mapActions([
        'addHabit',
      ]),
      newHabit() {
        const habitParams = {
            "name": this.habit.name,
            "description": this.habit.description,
            "best": this.habit.best,
            "user_id": this.currentUser.id
        }
          this.addHabit(habitParams, this.routeTo('Top'))
        },
      routeTo(routeName) {
        this.$router.push({ name: routeName })
      },
    }
  }
</script>