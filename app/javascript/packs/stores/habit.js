import axios from 'axios'

export default ({

  state: {
    habit: {},
    habits: [],
    currentHabitId: null,
    allHabits: [],
    pageNumber: 1,
    pageSize: 5,
    // habitDetail: {},
  },

  getters: {
    habit(state) {
      return state.habit
    },
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
    // habitDetail(state) {
    //   return state.habitDetail
    // },

  },

  mutations: {
    habit(state, payload) {
      state.habit = payload
    },
    clearHabit(state) {
      state.habit = {}
    },
    updateHabit(state, { value, keyName }) {
      state.habit[keyName] = value
    },
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
    // habitDetail(state, payload) {
    //   state.habitDetail = payload.habit
    // },
    // clearHabitDetail(state) {
    //   state.habitDetail = null
    // },

    ascTime(state, sortKey) {
      const newHabits = state.allHabits
      newHabits.sort((a, b) => {
        let compare = 0
        if (a[sortKey] > b[sortKey]) {
          compare = 1
        } else if (b[sortKey] > a[sortKey]) {
          compare = -1
        }
        return compare
      })
      state.allHabits = newHabits
    },
    descTime(state, sortKey) {
      const newHabits = state.allHabits
      newHabits.sort((a, b) => {
        let compare = 0
        if (a[sortKey] > b[sortKey]) {
          compare = -1
        } else if (b[sortKey] > a[sortKey]) {
          compare = 1
        }
        return compare
      })
      state.allHabits = newHabits
    },

  },


  actions: {
    setHabit(context, habitObj) {
      context.commit('habit', habitObj )
    },
    clearHabit(context) {
      context.commit('clearHabit')
    },

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
    
    //   setHabitDetail(context, habitId) {
    //     context.commit('currentHabitId', { currentHabitId: habitId })
    //     axios
    //       .get('/api/v1/habit_detail', { params: { habit_id: habitId } })
    //       .then(response => {
    //         context.commit('habitDetail', { habit: response.data })
    //         //ここに画像のエンコード処理を書く
    //         if (response.data.image) {
    //           context.dispatch('setHabitImage', response.data.image )
    //         }
    //         if (response.data.location_id !== null) {
    //           context.dispatch('setLocations')
    //         }
    //       })
    //       .catch(error => {
    //         console.error(error)
    //       })
    // },
      setHabitDetail(context, habitId) {
        context.commit('currentHabitId', { currentHabitId: habitId })
        axios
          .get('/api/v1/habit_detail', { params: { habit_id: habitId } })
          .then(response => {
            context.commit('habit', response.data )
            //ここに画像のエンコード処理を書く
            if (response.data.location_id !== null) {
              context.dispatch('setLocations')
            }
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
      
      addHabit(context, habitParams, routeTo) {
        axios
        .post('/api/v1/habits', habitParams)
        .then(() => {
          context.commit('createFlash', { type: 'success', message: '新しい習慣を登録しました' });
          return routeTo;
        })
        .catch(error => {
          console.error(error);
          context.commit('createFlash', { type: 'error', message: '新しい習慣の登録に失敗しました' });
        })
    },
      
    updateHabit(context, habit, routeTo) {
      axios
        .patch(`/api/v1/habits/${habit.id}`, habit)
        .then(() => {
          context.commit('createFlash', { type: 'success', message: '習慣の修正に成功しました' });
          return routeTo;
        })
        .catch(error => {
          console.error(error);
          context.commit('createFlash', { type: 'error', message: '習慣の修正に失敗しました' });
        })
    },
    
    destroyHabit(context, habitId, routeTo) {
      axios
        .delete(`/api/v1/habits/${habitId}`, { id: habitId })
        .then(() => {
          context.commit('createFlash', { type: 'info', message: '習慣の削除に成功しました' });
          return routeTo;
        })
        .catch(error => {
          console.error(error)
          context.commit('createFlash', { type: 'error', message: '習慣の削除に失敗しました' });
        })
    },
    
    changePageSize(context, pageSize) {
      context.commit('pageSize', { pageSize: pageSize });
      context.commit('pageNumberInit');
    },

    changePageNumber(context, pageNumber) {
      context.commit('pageNumber', { pageNumber: pageNumber })
    },

    ascTime(context, sortKey) {
      context.commit('ascTime', sortKey)
    },
    descTime(context, sortKey) {
      context.commit('descTime', sortKey)
    },

  },

})