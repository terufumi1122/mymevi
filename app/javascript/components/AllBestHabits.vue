<template>
  <div>
    <div class="vertical-spacer"></div>
    <div v-for="habit in allHabits" :key="habit.id">
      <BestItem
       :avatorColor="avatorColor[habit.best]"
       :habitNumber="habit.best"
       :habitTitle="habit.name"
       :userName="habit.user_name + 'さんのベスト' + habit.best + '位の習慣です！'"

       :habitId="habit.id"
       :userId="currentUser.data.id"
       :favorites="favorites"
       :isDisabled="habit.user_id === currentUser.data.id"
       >
        <template v-slot:habit_id>【habit.id】{{ habit.id }}</template>
        <template v-slot:habit_user_id>【habit.user_id】{{ habit.user_id }}</template>
        <template v-slot:currentUser_id>【currentUser.data.id】{{ currentUser.data.id }}</template>
      </BestItem>
      <div class="vertical-spacer"></div>
    </div>
    <div class="vertical-spacer"></div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';

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
    ...mapGetters([
      'allHabits',
      'allFavorites',
      'currentUser',
    ]),
    favorites() {
      return this.allFavorites
    },
  },
  created() {
    this.setAllHabits();
    this.setAllFavorites();
  },
  methods: {
    ...mapActions([
      'setAllHabits',
      'setAllFavorites'
    ]),
  }
}
</script>

<style scoped>
.vertical-spacer {
  margin-top: 10px;
  margin-bottom: 10px;
}
</style>