export default ({

  state: {
    loading: false,
  },

  getters: {
    loading(state) {
      return state.loading
    }
  },

  mutations: {
    loadingTrue(state) {
      state.loading = true
    },
    loadingFalse(state) {
      state.loading = false
    }
  }

})