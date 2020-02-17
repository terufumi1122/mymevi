<template>
  <div>
    <CommentForm
      :comment="comment"
      formLabel="コメント修正"
      @clickButton="updateComment($router.push({ name: 'HabitDetail'}))"
    >コメントを修正する</CommentForm>

    <v-container class="mx-auto text-center">
      <v-btn
        dark
        color="red"
        @click="destroyComment($router.push({ name: 'HabitDetail' }))"
      >
        <v-icon>mdi-trash</v-icon>
        削除する
      </v-btn>

      <v-btn
        dark
        color="gray"
        :to="{ name: 'HabitDetail'}"
      >
        キャンセル
      </v-btn>
    </v-container>

  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'
  import CommentForm from './CommentForm'

  export default {
    name: 'CommentEdit',
    components: {
      CommentForm,
    },
    computed: {
      ...mapGetters([
        'comment',
      ])
    },
    methods: {
      ...mapActions([
        'updateComment',
        'destroyComment',
      ])
    }
  }
</script>