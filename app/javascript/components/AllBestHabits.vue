<template>
  <div>
    <div class="vertical-spacer"></div>

    <div v-for="habit in allHabits" :key="habit.id">
      <BestItem
       v-if="habit.best === 1"
       :avatorColor="avatorColor[habit.best]"
       :habitNumber="habit.best"
       :habitTitle="habit.name"
       :userName="habit.user_name + 'さんのベスト' + habit.best + '位の習慣です！'"
       ></BestItem>
      <BestItem
       v-if="habit.best === 2"
       :avatorColor="avatorColor[habit.best]"
       :habitNumber="habit.best"
       :habitTitle="habit.name"
       :userName="habit.user_name + 'さんのベスト' + habit.best + '位の習慣です！'"
       ></BestItem>
      <BestItem
       v-if="habit.best === 3"
       :avatorColor="avatorColor[habit.best]"
       :habitNumber="habit.best"
       :habitTitle="habit.name"
       :userName="habit.user_name + 'さんのベスト' + habit.best + '位の習慣です！'"
       ></BestItem>
      <div class="vertical-spacer"></div>
    </div>
    <div class="vertical-spacer"></div>
  </div>
</template>

<script>
import axios from 'axios';
import BestItem from './BestItem';

export default {
  name: 'AllBestHabits',
  components: {
    BestItem,
  },
  data() {
    return {
      avatorColor: {
        1: 'yellow',
        2: 'grey lighten-2',
        3: 'brown lighten-2',
      }
    }
  },
  computed:{
    allHabits() {
      return this.$store.getters.allHabits
    }
  },
  created() {
    // createdのタイミングで全習慣を読み込むactionsを発動したい
    this.$store.dispatch('setAllHabits')
  },
}
</script>

<style scoped>
.vertical-spacer {
  margin-top: 10px;
  margin-bottom: 10px;
}
</style>