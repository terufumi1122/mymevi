import axios from 'axios'

export default ({

  state: {
    currentUser: null,
    headers: null,
    sampleLogined: false,
  },

  getters: {
    currentUser(state) {
      return state.currentUser;
    },
    sampleLogined(state) {
      return state.sampleLogined;
    }
  },

  mutations: {
    currentUser(state, payload) {
      state.currentUser = payload.user;
    },
    signIn(state, payload) {
      state.headers = {
        "access-token": payload["access-token"],
        "client": payload["client"],
        "uid": payload["uid"],
      };
    },
    signOut(state) {
      state.headers = null;
      state.currentUser = null;
      state.sampleLogined = false;
    },
    sampleLogined(state) {
      state.sampleLogined = true;
    }
  },

  actions: {
    signUp(context, userParams) {
      axios
        .post('/api/v1/auth', userParams)
        .then(function (response) {
          context.commit('currentUser', { user: response.data });
          context.commit('signIn', response.headers);
        })
        .catch(function (error) {
          console.error(error);
          // context.commit('currentUser', { user: error });
          alert(error);
        });
    },
    signIn(context, userParams) {
      axios
        .post('/api/v1/auth/sign_in', userParams)
        .then(function (response) {
          context.commit('currentUser', { user: response.data });
          context.commit('signIn', response.headers);
        })
        .catch(function (error) {
          console.error(error);
          // context.commit('currentUser', { user: error });
          alert(error)
        });
    },
    signOut(context) {
      axios
        .delete('/api/v1/auth/sign_out', { headers: context.state.headers })
        .then(function () {
          context.commit('signOut');
        })
        .catch(function (error) {
          alert(error);
        })
    },
    updateUser(context, userParams) {
      axios
        .put('/api/v1/auth', userParams, { headers: context.state.headers })
        .then(function (response) {
          context.commit('currentUser', { user: response.data });
          context.commit('signIn', response.headers);
        })
        .catch(function (error) {
          alert(error);
        })
      },
    deleteUser(context) {
        axios
        .delete('/api/v1/auth', { headers: context.state.headers })
        .then(function () {
          context.commit('signOut')
        })
        .catch(function (error) {
          alert(error);
        })
      },
      sampleLogin(context) {
        axios
        .post('/api/v1/samplelogin')
        .then(function (response) {
          context.commit('currentUser', { user: { data: response.data} });
        })
        .catch(function (error) {
          alert(error);
        })
        context.commit('sampleLogined')
    }
  },

})
