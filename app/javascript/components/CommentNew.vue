<template>
  <div>
    <CommentForm
      :comment="comment"
      formLabel="新規コメント作成"
      @clickButton="createComment()"
    >コメントを投稿する</CommentForm>

  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'
  import CommentForm from './CommentForm'

  export default {
    name: 'CommentNew',
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
        'createComment',
      ])
    }
  }
</script>