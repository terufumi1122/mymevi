export default ({

  state: {
    loading: true,
  },

  getters: {
    loading(state) {
      return state.loading
    }
  },

  mutations: {
    loading(state) {
      state.loading = !state.loading
    }
  },

  actions: {
    loading(context) {
      context.commit('loading')
    }

  }
})