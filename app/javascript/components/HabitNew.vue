<template>
  <div>
    <HabitForm
      formTitle="新規習慣登録"
      buttonName="新しい習慣を登録する"
      :habit="habit"
      :uploadedImage="uploadedImage"
      buttonColor="blue"
      @clickButton="newHabit"
    >
          <v-col
            cols="12"
            md="4"
          >
            <label>
              <v-img :src="habit.image" ></v-img>
              <ImageUploader
                v-bind="habit"
                v-model="habit.image"
                :params="{ limit: 1000, unit: 'kb', allow: 'jpg,png' }"
              ></ImageUploader>
            </label>
          </v-col>

    </HabitForm>
  </div>
</template>


<script>
import { mapGetters, mapActions } from 'vuex'
import HabitForm from './HabitForm.vue'
import ImageUploader from './ImageUploader.vue'

  export default {
    name: 'HabitNew',
    components: {
      HabitForm,
      ImageUploader,
    },
    data() {
      return {
        habit: {},
        //親コンポーネントで動くか検証
        error: '',
        message: '',
        uploadedImage: '',
        fileRules: [
          value => !value || value.size < 2000000 || 'ファイルサイズは2MB以下でお願いします',
        ],
        //親コンポーネントで動くか検証
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
        if (!this.habit.location_id) {
          this.habit.location_id = 1
        }
        const habitParams = {
            name: this.habit.name,
            description: this.habit.description,
            best: this.habit.best,
            user_id: this.currentUser.id,
            location_id: this.habit.location_id,
            image: this.habit.image
        }
          this.addHabit(habitParams, this.routeTo('Top'))
        },
      routeTo(routeName) {
        this.$router.push({ name: routeName })
      },
    }
  }
</script>