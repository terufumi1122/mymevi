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
      state.favorites = state.favorites.filter(favorite => !(favorite.user_id === payload.likeData.user_id && favorite.habit_id === payload.likeData.habit_id ))
    },

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
    },
    addLike(context, likeParams) {
      axios
        .post('/api/v1/favorite/create', likeParams)
        .then(function (response) {
          context.commit('addLike', { newLike: { id: response.data.id, user_id: response.data.user_id, habit_id: response.data.habit_id } });
        })
        .catch(function (error) {
          console.error(error);
          alert(error);
        });
    },
    deleteLike(context, likeParams) {
      context.commit('deleteLike', { likeData: {user_id: likeParams.user_id, habit_id: likeParams.habit_id }})
      axios
        .delete('/api/v1/favorite', likeParams)
        .then(function (response) {
          context.commit('allFavorites', { favorites: response.data })
        })
        .catch(function (error) {
          console.error(error);
          alert(error);
        })
    }
  },

})
