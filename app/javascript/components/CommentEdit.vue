<template>
  <div>
    <CommentForm
      :comment="comment"
      formLabel="コメント修正"
      @clickButton="updateComment($router.push({ name: 'HabitDetail'}))"
    >コメントを修正する</CommentForm>

    <v-container class="mx-auto text-center">
      <Dialog
        @clickDialogButton="destroyComment($router.push({ name: 'HabitDetail' }))"
      >
        <v-icon>mdi-trash-can</v-icon>
        コメントを削除する
      </Dialog>

      <v-btn
        class="mt-3"
        dark
        color="gray"
        :to="{ name: 'HabitDetail'}"
      >
        戻る
      </v-btn>
    </v-container>

  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'
  import CommentForm from './CommentForm'
  import Dialog from './Dialog'

  export default {
    name: 'CommentEdit',
    components: {
      CommentForm,
      Dialog,
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