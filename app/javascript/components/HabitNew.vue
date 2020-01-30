<template>
  <div>
    <HabitForm
      formTitle="新規習慣登録"
      buttonName="新しい習慣を登録する"
      :habit="habit"
    ></HabitForm>
  </div>
</template>


<script>
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
  }
</script>