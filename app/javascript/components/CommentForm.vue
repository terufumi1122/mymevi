<template>
  <div class="mb-3">
    <v-card
      class="mx-auto my-12"
      max-width="374"
    >
      <v-container>
        <v-form>
          <v-row
            class="mx-3"
          >
            <v-textarea
              :value="comment.content"
              @input="updateCommentParams($event, 'content')"
              :rules="commentRules"
              :label="formLabel"
              required
              clearable
            ></v-textarea>
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
    </v-card>
  </div>
</template>

<script>
  import { mapActions } from 'vuex'

  export default {
    name: 'CommentForm',
    props: {
      formLabel: String,
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
        this.$store.commit('updateCommentParams', { value: event, keyName })
      }
    }
  }
</script>