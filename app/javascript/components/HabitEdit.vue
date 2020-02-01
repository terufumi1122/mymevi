<template>
  <div>
    <HabitForm
      formTitle="習慣を修正"
      buttonName="上記内容で修正する"
      :habit="habitDetail"
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
      'habitDetail',
    ])
  },
  methods: {
    ...mapActions([
      "updateHabit",
    ]),
    editHabit() {
      const habitParams = {
        id: this.habitDetail.id,
        name: this.habitDetail.name,
        description: this.habitDetail.description,
        best: this.habitDetail.best
      };
      this.updateHabit(habitParams, this.routeTo("Top"));
    },
    routeTo(routeName) {
      this.$router.push({ name: routeName });
    }
  }
};
</script>
