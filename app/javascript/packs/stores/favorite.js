import axios from 'axios';

export default ({

  state: {
    favorites: null,
  },

  getters: {
    allFavorites(state) {
      return state.favorites;
    },
    getFavoritesByUserId(state, currentUserId) {
      return state.favorites.filter(favorite => favorite.user_id === currentUserId);
      // return state.favorites;
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
