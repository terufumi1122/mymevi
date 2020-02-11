<template>
  <div>
    <v-img
      :src="user.image"
    ></v-img>
    <ImageUploader
      :value="user.image"
      @change="updateUserParams($event, 'image')"
      :params="{ limit: 1000, unit: 'kb', allow: 'jpg,png' }"
      :deleteShow="user.image !== null"
      @deleteClick="deleteImage()"
    ></ImageUploader>
    <v-row>
      <v-spacer></v-spacer>
      <router-link :to="{ name: 'UserDetail' }">
        <v-btn
          @click="sendImage()"
        >変更する</v-btn>
      </router-link>
      <v-spacer></v-spacer>
      <v-btn
        :to="{ name: 'UserDetail' }"
      >戻る</v-btn>
      <v-spacer></v-spacer>
    </v-row>
  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'
  import ImageUploader from './ImageUploader'

  export default {
    name: 'UserImage',
    components: {
      ImageUploader,
    },
    computed: {
      ...mapGetters([
        'user'
      ])
    },
    methods: {
      ...mapActions([
        'sendImage',
        'deleteUserImage'
      ]),
      updateUserParams(event,keyName) {
        console.log(event)
        this.$store.commit('updateUserParams', { value: event, keyName })
      },
      deleteImage() {
        this.deleteUserImage(this.$router.push({ name: 'UserDetail' }))
      }
    }
  }
</script>