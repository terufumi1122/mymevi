export default {
  state: {
    habitImage: null,
    userImages: [],
  },

  getters: {

    habitImage(state) {
      return state.habitImage
    },

    userImages(state) {
      return state.userImages
    }

  },


  mutations: {

    habitImage(state, payload) {
      state.habitImage = payload
    },

    userImages(state, payload) {
      state.userImages = payload
    },

    deleteHabitImage(state) {
      state.habitImage = null
    }

  },


  actions: {

    setHabitImage(context, file) {
      context.commit('habitImage', file)
    },

    deleteHabitImage(context) {
      context.commit('deleteHabitImage')
    },

    setUserImages(context, file) {
      context.commit('habitImage', file)
    },

  }
}