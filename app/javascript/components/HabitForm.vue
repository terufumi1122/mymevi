<template>
  <v-container class="mx-auto text-center">
    <v-form>
      <h2>{{ formTitle }}</h2>

        <v-row>
          <v-col>
            <v-text-field
              :value="habit.name"
              @input="updateHabit($event, 'name')"
              :rules="nameRules"
              :counter="20"
              label="習慣名"
              required
            ></v-text-field>
          </v-col>
        </v-row>

        <v-row>
          <v-col>
            <v-textarea
              :value="habit.description"
              @input="updateHabit($event, 'description')"
              :rules="descriptionRules"
              :counter="140"
              label="習慣詳細"
              required
            ></v-textarea>
          </v-col>
        </v-row>

        <v-row>
          <v-col>
            <v-text-field
              :value="habit.merit"
              @input="updateHabit($event, 'merit')"
              :rules="meritRules"
              :counter="100"
              label="実感した（したい）メリット"
              required
            ></v-text-field>
          </v-col>
        </v-row>

        <!-- <v-row>
          <v-col>
            <v-select
              :value="habit.location_id"
              @input="updateHabit($event, 'location_id')"
              :items="myLocations"
              label="My定番スポットと紐付ける"
            ></v-select>
          </v-col>
        </v-row> -->

        <slot></slot>

    </v-form>

    <v-row>
      <v-col>
        <v-img
          v-model="habit"
          :src="habit.image"
        ></v-img>
        <ImageUploader
          v-bind="habit"
          :value="habit.image"
          @change="updateHabit($event, 'image')"
          :params="{ limit: 1000, unit: 'kb', allow: 'jpg,png' }"
          :deleteShow="habit.image !== null"
          @deleteClick="deleteHabitImage()"
        ></ImageUploader>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <div>
          <v-btn
            class="mb-3"
            :color="buttonColor"
            dark
            @click="$emit('clickButton')"
          >
            <v-icon>mdi-plus-box</v-icon>
            {{ buttonName }}
          </v-btn>
        </div>
      </v-col>
    </v-row>
    <Dialog
      @clickDialogButton="destroy"
    >
      <v-icon>mdi-trash-can</v-icon>
      習慣を削除する
    </Dialog>
  </v-container>
</template>


<script>
import { mapGetters, mapActions } from 'vuex';
import ImageUploader from './ImageUploader'
import Dialog from "./Dialog.vue";

  const maxHabitAmount= 3;
  const habitAmount = Array.from(Array(maxHabitAmount).keys(), x => x + 1)

  export default {
    name: 'HabitForm',
    components: {
      ImageUploader,
      Dialog,
    },
    props: {
      formTitle: String,
      buttonName: String,
      habit: {},
      buttonColor: String,
      clickButton: '',
    },
    data() {
      return {
        items: habitAmount,
        nameRules: [
          value => !!value || '習慣名の入力は必須です',
          value => value.length <= 20 || '習慣名は20文字以内で入力して下さい'
        ],
        meritRules: [
          value => !!value || '実感した（したい）メリットの入力は必須です',
          value => value.length <= 100 || '実感した（したい）メリットは100文字以内で入力して下さい'
        ],
        descriptionRules: [
          value => value.length <= 140 || '習慣の詳細は140文字以下で入力して下さい',
        ],
      }
    },
    computed: {
      ...mapGetters([
        'currentUserLocations'
      ]),
      myLocations() {
        return this.currentUserLocations.map( l => {
          return { value: l.id, text: l.name }
        })
      }
    },
    destroyed() {
      this.clearHabit()
    },
    methods: {
      ...mapActions([
        'destroyHabit',
        'setLocations',
        'setHabit',
        'deleteHabitImage',
        'clearHabit'
      ]),

      updateHabit(event, keyName) {
        this.$store.commit('updateHabit', { value: event, keyName })
      },

      destroy() {
        this.destroyHabit(this.habit.id, this.$router.push({name: 'Top'}))
      },
    },
    created() {
      this.setLocations()
    }
  }
</script>