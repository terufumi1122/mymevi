import axios from 'axios'
import Axios from 'axios'

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
    },
    updateCommentParams(state, { value, keyName }) {
      state.comment[keyName] = value
    },
    clearComment(state) {
      state.comment = {}
    }
  },

  actions: {

    setComments(context) {
      const habit_id = context.getters.habit.id
      axios
      .get(`/api/v1/comments/${habit_id}`, { params: { id: habit_id } })
      .then(response => {
        context.commit('comments', { comments: response.data })
        context.dispatch('getAvatars')
      })
      .catch(error => {
        console.error(error)
        context.dispatch('createFlash', { type: 'error', message: 'コメントの取得に失敗しました' });
      })
    },

    createComment(context) {
      const commentParams = {
        content: context.state.comment.content,
        user_id: context.getters.currentUser.id,
        habit_id: context.getters.currentHabitId,
      }
      axios
        .post(`/api/v1/comments`, commentParams)
        .then(response => {
          context.commit('comment', { comment: response.data })
          context.commit('clearComment')
          context.dispatch('createFlash', { type: 'success', message: 'コメントの作成に成功しました' });
        })
        .catch(error => {
          console.error(error)
          context.dispatch('createFlash', { type: 'error', message: 'コメントの作成に失敗しました' });
      })
    },

    getAvatars(context) {
      const comments = context.getters.comments
      const userIds = comments.map(comment => comment.user_id)
      const commentUsers = Array.from(new Set(userIds))
      
      axios
        .post('/api/v1/user/avatars', { users: commentUsers })
        .then(response => {
        context.commit('avatars', response.data)
        console.log('avatarsを取得しました')
        })
        .catch(error => {
          console.error(error)
          context.dispatch('createFlash', { type: 'error', message: 'アバターの取得に失敗しました'})
      })
    }
  }

})