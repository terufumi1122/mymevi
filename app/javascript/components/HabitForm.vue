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
              v-model="habit.name"
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
              v-model="habit.description"
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
              v-model="habit.best"
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
              v-model="habit.location_id"
              :items="myLocations"
              label="My定番スポットと紐付ける"
            ></v-select>
          </v-col>

          <slot></slot>

          <!-- ここに画像登録ボタンがほしい -->
          <!-- <v-col
            cols="12"
            md="4"
          >
            <v-file-input
              v-model="uploadedImage"
              :rules="fileRules"
              accept="image/png, image/jpeg, image/bmp"
              placeholder="写真・画像を登録する"
              prepend-icon="mdi-camera"
              @change="$emit('fileInput')"
            ></v-file-input>
          </v-col> -->

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

  const maxHabitAmount= 3;
  const habitAmount = Array.from(Array(maxHabitAmount).keys(), x => x + 1)

  export default {
    name: 'HabitForm',
    props: {
      formTitle: '',
      buttonName: '',
      habit: {},
      uploadedImage: '',
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
        // fileRules: [
        //   value => !value || value.size < 2000000 || 'ファイルサイズは2MB以下でお願いします',
        // ],
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
        'setLocations'
      ]),
      destroy() {
        this.destroyHabit(this.habit.id, this.$router.push({name: 'Top'}))
      },

      //これは要る。
      // onFileChange() {
      //   let file = event.target.files[0] || event.dataTransfer.files
      //   let reader = new FileReader()
      //   reader.onload = () => {
      //     this.uploadedImage = event.target.result
      //     this.habit.image = this.uplpadedImage
      //   }
      //   reader.readAsDataURL(file)
      // },

      //これはhabit.jsのaddHabitでいける。
      // postItem() {
      //   return new Promise((resolve, _) => {
      //     axios
      //       .post('/api/v1/habits', this.habit )
      //       .then(response => {
      //         this.habit = {}
      //         this.uploadedImage = ''
      //         this.$refs.file.value = ''
      //         resolve(response)
      //       }).catch( error => {
      //         console.error(error)
      //       })
      //   })
      // }
    },
    created() {
      this.setLocations()
    }
  }
</script>