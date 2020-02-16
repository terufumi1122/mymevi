import axios from 'axios'

export default ({

  state: {
    comments: [],
    comment: {},
  },

  getters: {
    comments(state) {
      return state.comments
    },
    comment(state) {
      return state.comment
    }
  },

  mutations: {
    comments(state, payload) {
      state.comments = payload.comments
    },
    comment(state, payload) {
      state.comment = payload.comment
    }
  },

  actions: {

    setComments(context) {
      const habit_id = context.getters.habit.id
      axios
      .get(`/api/v1/comments/${habit_id}`, { params: { id: habit_id } })
      .then(response => {
        context.commit('comments', { comments: response.data })
      })
      .catch(error => {
        console.error(error)
        context.dispatch('createFlash', { type: 'error', message: 'コメントの取得に失敗しました' });
      })
    },

    createComment(context, comment) {
      axios
        .post(`/api/v1/comments`, comment)
        .then(response => {
          context.commit('comment', { comment: response.data })
          context.dispatch('createFlash', { type: 'success', message: 'コメントの作成に成功しました' });
        })
        .catch(error => {
          console.error(error)
          context.dispatch('createFlash', { type: 'error', message: 'コメントの作成に失敗しました' });
      })
    }
  }

})