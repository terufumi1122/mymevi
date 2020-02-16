import axios from 'axios'

export default ({

  state: {
    comments: [],
    // comment: {},
  },

  getters: {
    comments(state) {
      return state.comments
    },
    // comment(state) {
    //   return state.comment
    // }
  },

  mutations: {
    comments(state, payload) {
      state.comments = payload.comments
    },
    // comment(state, payload) {
    //   state.comment = payload.comment
    // }
  },

  actions: {
    // setComments(context) {
    //   axios
    //     .get('/api/v1/comments')
    //     .then(response => {
    //       context.commit('comments', { comments: response.data })
    //     })
    //     .catch(error => {
    //       console.error(error)
    //       context.dispatch('createFlash', { type: 'error', message: 'コメントの取得に失敗しました' });
    //   })
    // },
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
  }

})