<template>
  <div>
    <HabitForm
      v-model="habit"
      formTitle="習慣を修正"
      buttonName="この内容で修正する"
      :habit="habit"
      buttonColor="teal"
      @clickButton="editHabit"
    ></HabitForm>
  </div>
</template>


<script>
import { mapGetters, mapActions } from "vuex";
import HabitForm from "./HabitForm.vue";

export default {
  name: "HabitEdit",
  components: {
    HabitForm,
  },
  computed: {
    ...mapGetters([
      'habit'
    ])
  },
  methods: {
    ...mapActions([
      'updateHabit',
    ]),
    editHabit() {
      const habitParams = {
        id: this.habit.id,
        name: this.habit.name,
        merit: this.habit.merit,
        description: this.habit.description,
        best: this.habit.best,
        user_id: this.habit.user_id,
        location_id: this.habit.location_id,
        image: this.habit.image
      }
      this.updateHabit(habitParams, this.$router.push({ name: 'Top' }));
    },
  }
};
</script>
