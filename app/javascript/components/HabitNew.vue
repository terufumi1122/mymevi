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
    <!-- 親コンポーネントに入れてみたらどうなるか検証 -->
          <v-col
            cols="12"
            md="4"
          >
            <label>
              <img
                :src="habit.image"
                alt="habit.image"
              >
              <ImageUploader
                v-bind="habit"
                v-model="habit.image"
                :params="{ limit: 1000, unit: 'kb', allow: 'jpg,png' }"
              ></ImageUploader>
            </label>

          </v-col>


    <!-- 親コンポーネントに入れてみたらどうなるか検証 -->
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
        // habit.image: '',
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

      //ここから写経
      // setError(error, text) {
      //   this.error = (error.response && error.response.data && error.response.data.error) || text
      // },
      // getBase64(file) {
      //   return new Promise( (resolve, reject) => {
      //     const reader = new FileReader()
      //     reader.readAsDataURL(file)
      //     reader.onload = () => resolve(reader.result)
      //     reader.onerror = error => reject(error)
      //   })
      // },
      // onImageChange(event) {
      //   const images = event.target.files || event.dataTransfer.files
      //   this.getBase64(images[0])
      //     .then(image => this.habit.image = image)
      //     .catch(error => this.setError(error, '画像のアップロードに失敗しました'))
      // },
      upload() {
        if (this.habit.image) {
          //ここにaxiosでpostリクエストを投げる処理を書く
          console.log('画像アップしました！...コードを書けばね。')
          //
          this.message = 'アップロードしました'
          this.error = ''
        } else {
          this.error = '画像がありません'
        }
      },




      //以下は一旦使わない。
      // onFileChange() {
      //   let file = event.target.files[0] || event.dataTransfer.files
      //   let reader = new FileReader()
      //   reader.onload = (event) => {
      //     this.uploadedImage = event.target.result
      //     this.habit.image = this.uploadedImage
      //   }
      //   reader.readAsDataURL(file)
      // },
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