<template>
  <v-container>
    <v-row>
      <v-spacer></v-spacer>
        <div>
          <p id="error" v-show="error">{{ error }}</p>
          <v-btn
            color="green"
            dark
            @click="btnClick"
          >
            <v-icon>mdi-camera</v-icon>
            画像をアップロードする
          </v-btn>
          <input
            ref="input"
            type="file"
            id="image_name"
            class="input_image"
            accept="image/jpeg, image/png"
            @change="onImageChange"
          />
        </div>
      <v-spacer></v-spacer>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'ImageUploder',
  props: {
    id: Number,
    currentImage: String
  },
  model: {
    // このcurrentImageは親で指定した(v-model="avatar")と同値。
    prop: 'currentImage',
    event: 'change'
  },
  data () {
    return {
      message: '',
      error: ''
    }
  },
  computed: {
    ...mapGetters([
      'habitImage'
    ])
  },
  methods: {
    ...mapActions([
      'convertImage',
      'setHabitImage'
    ]),
    btnClick() {
      this.$refs.input.click();
    },
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    getBase64 (file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader()
        reader.readAsDataURL(file)
        reader.onload = () => resolve(reader.result)
        reader.onerror = error => reject(error)
      })
    },
    setImage (currentImage) {
      this.$emit('change', currentImage)
    },
    onImageChange (e) {
      const images = e.target.files || e.dataTransfer.files
        this.getBase64(images[0])
          .then(image => {
            this.setImage(image)
          })
          .catch(error => this.setError(error, '画像のアップロードに失敗しました。'))
    },
  }
}
</script>

<style scoped>
.input_image {
  display: none;
}
</style>
