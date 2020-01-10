export default ({

  state: {
    favorites: null,
  },

  getters: {
    favorites(state) {
      return state.favorites;
    }
  },

  mutations: {
    allFavorites(state, payload) {
      state.favorites = payload.favorites
    }
  },

  actions: {
    getAllFavorites() {
      axios
        .get('/api/v1/favoritses')
        .then(function (response) {
          context.commit('allFavorites', { favorites: response.data })
        })
        .catch(function (error) {
          alert(error)
        })
    }
  },

  actionts: {

  }

})
