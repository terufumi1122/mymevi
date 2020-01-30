<template>
  <div>
    <HabitForm
      formTitle="習慣を修正"
      buttonName="上記内容で修正する"
      :habit="habit"
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
        'currentHabit'
      ])
    },
    methods: {
      // ...mapActions([
      //   'setCurrentHabit'
      // ]),
      setCurrentHabit() {
        this.habit = this.currentHabit
      }
    },
    created() {

    }
  }
</script>