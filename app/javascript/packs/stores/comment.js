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
      state.comment = payload
    },
    clearComment(state) {
      state.comment = {}
    },
    updateCommentParams(state, { value, keyName }) {
      state.comment[keyName] = value
    },
  },

  actions: {
    setComment(context, comment) {
      context.commit('comment', comment)
    },
    clearComment(context) {
      context.commit('clearComment')
    },

    setComments(context) {
      const habit_id = context.getters.habit.id
      axios
      .get(`/api/v1/comments/${habit_id}`, { params: { id: habit_id } })
      .then(response => {
        context.commit('comments', { comments: response.data })
        context.dispatch('getCommentAvatars')
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
          context.dispatch('setComments')
          context.dispatch('createFlash', { type: 'success', message: 'コメントの作成に成功しました' });
        })
        .catch(error => {
          console.error(error)
          context.dispatch('createFlash', { type: 'error', message: 'コメントの作成に失敗しました' });
      })
    },

    updateComment(context, routeTo) {
      const habitId = context.state.comment.habit_id
      const commentId = context.state.comment.id
      const commentParams = {
        id: commentId,
        content: context.state.comment.content,
        user_id: context.state.comment.user_id,
        habit_id: habitId,
      }
      axios
      .patch(`/api/v1/comments/${commentId}`, commentParams)
      .then(response => {
        context.commit('comment', response.data )
        context.dispatch('createFlash', { type: 'success', message: 'コメントの修正に成功しました' })
        context.dispatch('setHabitDetail', habitId )
        context.commit('clearComment')
        return routeTo
      })
      .catch(error => {
        console.error(error)
        context.dispatch('createFlash', { type: 'error', message: 'コメントの修正に失敗しました' });
      })
    },
    
    destroyComment(context, routeTo) {
      const habitId = context.state.comment.habit_id
      const commentId = context.state.comment.id
      axios
      .delete(`/api/v1/comments/${commentId}`)
        .then(() => {
          context.dispatch('createFlash', { type: 'info', message: 'コメントを削除しました' });
          context.dispatch('setComments', habitId)
          context.dispatch('setHabitDetail', habitId )
          return routeTo
        })
        .catch(error => {
          console.error(error)
          context.dispatch('createFlash', { type: 'error', message: 'コメントの削除に失敗しました' });
      })
    },

    getCommentAvatars(context) {
      const comments = context.getters.comments
      const userIds = comments.map(comment => comment.user_id)
      const commentUsers = Array.from(new Set(userIds))
      
      axios
        .post('/api/v1/user/avatars', { users: commentUsers })
        .then(response => {
        context.commit('avatars', response.data)
        })
        .catch(error => {
          console.error(error)
          context.dispatch('createFlash', { type: 'error', message: 'アバターの取得に失敗しました'})
      })
    }
  }

})