<template>
    <v-container>
      <v-form>
        <h2>{{ formTitle }}</h2>
        <v-row>
          <v-text-field
            :value="comment.content"
            @input="updateCommentParams($event, 'password')"
            :rules="passwordRules"
            label="新規コメント"
            required
          ></v-text-field>
        </v-row>

        <v-row>
          <v-spacer></v-spacer>
          <v-btn
          color="green"
          dark
          @click="$emit('clickButton')"
          >
            <slot>初期値だよー。</slot>
          </v-btn>
          <v-spacer></v-spacer>
        </v-row>
      </v-form>
    </v-container>
</template>

<script>
  import { mapActions } from 'vuex'

  export default {
    name: 'CommentForm',
    props: {
      formTitle: String,
      comment: Object,
    },
    data() {
      return {
        valid: false,
        commentRules: [
          v => !!v || 'コメントの入力は必須です',
        ],
      }
    },
    destroyed() {
      this.clearComment()
    },
    methods: {
      ...mapActions ([
        'clearComment'
      ]),
      updateCommentParams(event,keyName) {
        console.log(event)
        this.$store.commit('updateCommentParams', { value: event, keyName })
      }
    }
  }
</script>