import axios from 'axios'

export default ({

  state: {
    habits: [],
    currentHabitId: null,
    allHabits: [],
    pageNumber: 1,
    pageSize: 5,
    habitDetail: {},
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
    displayHabits(state) {
      return state.allHabits.slice(state.pageSize * (state.pageNumber - 1), state.pageSize * (state.pageNumber))
    },
    habitsLength(state) {
      return Math.ceil(state.allHabits.length / state.pageSize)
    },
    currentHabit(state) {
      return state.allHabits.find(habit => habit.id === state.currentHabitId )
    },
    habitDetail(state) {
      return state.habitDetail
    }

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
    pageSize(state, payload) {
      state.pageSize = payload.pageSize
    },
    pageNumber(state, payload) {
      state.pageNumber = payload.pageNumber
    },
    pageNumberInit(state) {
      state.pageNumber = 1
    },
    habitDetail(state, payload) {
      state.habitDetail = payload.habit
    }

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
      setCurrentHabit(context, habitId) {
        context.commit('currentHabitId', { currentHabitId: habitId })
        axios
          .get('/api/v1/habit_detail', { params: { habit_id: habitId } })
          .then(response => {
            context.commit('habitDetail', { habit: response.data[0] })
          })
          .catch(error => {
            console.error(error)
          })
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
      addHabit(context, habitParams) {
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
    },
    changePageSize(context, pageSize) {
      context.commit('pageSize', { pageSize: pageSize }),
        context.commit('pageNumberInit')
    },
    changePageNumber(context, pageNumber) {
      context.commit('pageNumber', { pageNumber: pageNumber })
    }
  },

})