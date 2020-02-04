<template>
  <div>
    <v-form>
      <v-container>
        <h2>{{ formTitle }}</h2>
        <v-row>
          <v-col
            cols="12"
            md="4"
          >
            <v-text-field
              :value="habit.name"
              @input="updateHabit($event, 'name')"
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
              :value="habit.description"
              @input="updateHabit($event, 'description')"
              :rules="descriptionRules"
              :counter="140"
              label="習慣詳細"
              required
            ></v-text-field>
          </v-col>
          <v-col
            cols="12"
            md="4"
          >
            <v-select
              :value="habit.best"
              @input="updateHabit($event, 'best')"
              :items=items
              label="自分の中の習慣ランキング"
              required
            ></v-select>
          </v-col>
          <v-col
            cols="12"
            md="4"
          >
            <v-select
              :value="habit.location_id"
              @input="updateHabit($event, 'location_id')"
              :items="myLocations"
              label="My定番スポットと紐付ける"
            ></v-select>
          </v-col>

          <slot></slot>

          <v-col
            cols="12"
            md="4"
          >
            <label>
              <v-img :src="habit.image" ></v-img>
              <ImageUploader
                v-bind="habit"
                :value="habit.image"
                @change="updateHabit($event, 'image')"
                :params="{ limit: 1000, unit: 'kb', allow: 'jpg,png' }"
              ></ImageUploader>
            </label>
          </v-col>

        </v-row>
      </v-container>
      <v-row>
        <v-spacer></v-spacer>
        <v-btn
          :color="buttonColor"
          dark
          @click="$emit('clickButton')"
        >
          <v-icon>mdi-plus-box</v-icon>
          {{ buttonName }}
        </v-btn>
        <v-spacer></v-spacer>
        <v-btn
          color="red"
          dark
          @click="destroy"
        >
          <v-icon>mdi-delete</v-icon>
          削除する
        </v-btn>
        <v-spacer></v-spacer>
      </v-row>
    </v-form>
  </div>
</template>


<script>
import { mapGetters, mapActions } from 'vuex';
import ImageUploader from './ImageUploader'

  const maxHabitAmount= 3;
  const habitAmount = Array.from(Array(maxHabitAmount).keys(), x => x + 1)

  export default {
    name: 'HabitForm',
    components: {
      ImageUploader,
    },
    props: {
      formTitle: '',
      buttonName: '',
      habit: {},
      buttonColor: '',
      clickButton: '',
    },
    data() {
      return {
        items: habitAmount,
        nameRules: [
          value => !!value || '習慣名の入力は必須です',
          value => value.length <= 20 || '習慣名は20文字以内で入力して下さい'
        ],
        descriptionRules: [
          value => value.length <= 140 || '習慣の詳細は140文字以下で入力して下さい',
        ],
      }
    },
    computed: {
      ...mapGetters([
        'locations'
      ]),
      myLocations() {
        return this.locations.map( location => {
          return { value: location.id, text: location.name }
        })
      }
    },
    methods: {
      ...mapActions([
        'destroyHabit',
        'setLocations',
        'setHabit'
      ]),

      updateHabit(event, keyName) {
        console.log(event)
        console.log(keyName)
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