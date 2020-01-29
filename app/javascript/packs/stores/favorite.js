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
    },
  },

  mutations: {
    allFavorites(state, payload) {
      state.favorites = payload.favorites
    },
    addLike(state, payload) {
      state.favorites.push(payload.newLike)
    },
    deleteLike(state, payload) {
      state.favorites = state.favorites.filter(favorite => !(favorite.user_id === payload.user_id && favorite.habit_id === payload.habit_id ))
    },

  },

  actions: {
    setAllFavorites(context) {
      axios
        .get('/api/v1/favorites')
        .then(response => {
          context.commit('allFavorites', { favorites: response.data })
        })
        .catch(error => {
          alert(error)
        })
    },
    setCurrentUserFavorites(context, userId) {
      axios
        .get('/api/v1/user_favorites', { params: { id: userId }})
        .then(response => {
          context.commit('allFavorites', { favorites: response.data })
        })
        .catch(error => {
          alert(error)
        })
    },
    addLike(context, likeParams) {
      axios
        .post('/api/v1/favorite/create',  likeParams)
        .then(response => {
          context.commit('addLike', { newLike: { id: response.data.id, user_id: response.data.user_id, habit_id: response.data.habit_id } });
        })
        .catch(error => {
          console.error(error);
          alert(error);
        });
    },
    deleteLike(context, likeParams) {
      context.commit('deleteLike', likeParams)
      axios
        .delete('/api/v1/favorite', {params: likeParams })
        .then(response => {
          context.commit('allFavorites', { favorites: response.data })
        })
        .catch(error => {
          console.error(error);
          alert(error);
        })
    }
  },

})
