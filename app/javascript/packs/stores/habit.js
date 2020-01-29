import axios from 'axios'

export default ({

  state: {
    habits: null,
    currentHabitId: null,
    allHabits: null,
  },

  getters: {
    habits(state) {
      return state.habits;
    },
    currentHabitId(state) {
      return state.currentHabitId;
    },
    allHabits(state) {
      return state.allHabits;
    },
  },

  mutations: {
    currentUserHabits(state, payload) {
      state.habits = payload.habits
    },
    currentHabitId(state, payload) {
      state.currentHabitId = payload.currentHabitId
    },
    allHabits(state, payload) {
      state.allHabits = payload.allHabits
    },
  },

  actions: {
    setCurrentUserHabits(context, currentUserId) {
      axios
        .get('/api/v1/habits', { params: { user_id: currentUserId } })
        .then(response => {
          context.commit('currentUserHabits', { habits: response.data })
        })
        .catch(error => {
          console.error(error)
        })
      },
      setCurrentHabitId(context, habitId) {
        context.commit('currentHabitId', { currentHabitId: habitId })
      },
      setAllHabits(context) {
        axios
        .get('/api/v1/allhabits')
        .then(response => {
          context.commit('allHabits', { allHabits: response.data })
        })
        .catch(error => {
          alert(error)
        })
      },
      addHabit(context, habitParams,) {
        axios
        .post('/api/v1/habits', habitParams)
        .then(response => {
          context.commit('createFlash', {type: 'success', message: '新しい習慣を登録しました'})
          return routeTo;
        })
        .catch(error => {
          console.error(error);
          context.commit('createFlash', {type: 'success', message: '新しい習慣の登録に失敗しました'})
        })
    }
  },

})