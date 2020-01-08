import axios from 'axios'

export default ({

  state: {
    habits: null,
    allHabits: null,
  },

  getters: {
    habits(state) {
      return state.habits;
    },
    allHabits(state) {
      return state.allHabits;
    },
  },

  mutations: {
    currentUserHabits(state, payload) {
      state.habits = payload.habits
    },
    allHabits(state, payload) {
      state.allHabits = payload.allHabits
    },
  },

  actions: {
    setCurrentUserHabits(context, currentUserId) {
      axios
        .get('/api/v1/habits', { params: { user_id: currentUserId } })
        .then(function (response) {
          context.commit('currentUserHabits', { habits: response.data })
        })
        .catch(function (error) {
          alert(error)
        })
    },
    setAllHabits(context) {
      axios
        .get('/api/v1/allhabits')
        .then(function (response) {
          context.commit('allHabits', { allHabits: response.data })
        })
        .catch(function (error) {
          alert(error)
        })
    },
    addHabit(context) {
      axios
        .post('/api/v1/habits', habitParams)
        .then(function (response) {
        })
        .catch(function (error) {
          console.error(error);
          alert(error)
        })
    }
  },

})