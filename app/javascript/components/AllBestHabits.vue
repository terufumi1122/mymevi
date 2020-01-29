<template>
  <v-container>
    <v-row>
      <v-spacer></v-spacer>
      <v-col cols="4">
        <v-select
          v-model="pageSize"
          no-data="選択して下さい"
          :items=pageSizeList
          @change="changeSize"
          label="1ページあたりの表示件数"
          dense
        ></v-select>
      </v-col>
      <v-spacer></v-spacer>
    </v-row>
    <v-pagination
      v-model="pageNumber"
      :length="habitsLength"
      @input="changeNumber"
      circle
    >
    </v-pagination>
    <div class="vertical-spacer"></div>
    <div v-for="habit in displayHabits" :key="habit.id">
      <BestItem
       :avatorColor="avatorColor[habit.best]"
       :habitNumber="habit.best"
       :habitTitle="habit.name"
       :userName="habit.user_name + 'さんのベスト' + habit.best + '位の習慣です！'"

       :habitId="habit.id"
       :userId="currentUser.id"
       :favorites="allFavorites"
       :isDisabled="habit.user_id === currentUser.id"
       >
      </BestItem>
      <div class="vertical-spacer"></div>
    </div>
    <div class="vertical-spacer"></div>
    <v-pagination
      v-model="pageNumber"
      :length="habitsLength"
      @input="changeNumber"
      circle
    >
    </v-pagination>
    <div class="vertical-spacer"></div>
  </v-container>
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
      pageNumber: 1,
      pageSize: 5,
      pageSizeList: [5, 10, 15, 20, 25, 30],
      // displayHabits: [],
      avatorColor: {
        1: 'yellow',
        2: 'grey lighten-2',
        3: 'brown lighten-2',
      }
    }
  },
  computed: {
    ...mapGetters([
      'allHabits',
      'allFavorites',
      'currentUser',
      'displayHabits',
      'habitsLength'
    ]),
    // habits() {
    //   return this.allHabits
    // },
    // habitsLength() {
    //   return Math.ceil(this.allHabits.length / this.pageSize)
    // },
    // favorites() {
    //   return this.allFavorites
    // },
    // displayHabits() {
    //   return this.allHabits.slice(0, this.pageSize)
    // }
  },
  created() {
    this.setAllHabits();
    this.setAllFavorites();
    // this.setDisplayHabits();
  },
  methods: {
    ...mapActions([
      'setAllHabits',
      'setAllFavorites',
      'changePageSize',
      'changePageNumber'
    ]),
    // setDisplayHabits() {
    //   this.displayHabits = this.allHabits.slice(0, this.pageSize)
    // },
    // changeDisplayHabits(){
    //   this.displayHabits = this.allHabits.slice(0, this.pageSize)
    // },
    // pageChange(number){
    //   this.displayHabits = this.allHabits.slice(this.pageSize*(number -1), this.pageSize*(number));
    // },
    changeNumber() {
      this.changePageNumber(this.pageNumber)
    },
    changeSize() {
      this.changePageSize(this.pageSize)
    }
  }
}
</script>

<style scoped>
.vertical-spacer {
  margin-top: 10px;
  margin-bottom: 10px;
}
</style>