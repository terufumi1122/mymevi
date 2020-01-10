import axios from 'axios';

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
    setAllFavorites(context) {
      axios
        .get('/api/v1/favorites')
        .then(function (response) {
          context.commit('allFavorites', { favorites: response.data })
        })
        .catch(function (error) {
          alert(error)
        })
    }
  },

})
