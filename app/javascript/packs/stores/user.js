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
      localStorage.setItem('currentUser', JSON.stringify(payload.user));
    },
    headers(state, payload) {
      let headers = {
        "access-token": payload["access-token"],
        "client": payload["client"],
        "uid": payload["uid"],
      }
      state.headers = headers
      localStorage.setItem('headers', JSON.stringify(headers))
    },
    signOut(state) {
      state.headers = null;
      state.currentUser = null;
      state.sampleLogined = false;
      localStorage.removeItem('currentUser');
      localStorage.removeItem('headers');
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
          context.commit('currentUser', { user: response.data.data });
          context.commit('headers', response.headers);
        })
        .catch(function (error) {
          console.error(error);
          alert(error);
        });
    },
    signIn(context, userParams) {
      axios
        .post('/api/v1/auth/sign_in', userParams)
        .then(function (response) {
          context.commit('currentUser', { user: response.data.data });
          context.commit('headers', response.headers);
        })
        .catch(function (error) {
          console.error(error);
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
          context.commit('currentUser', { user: response.data.data });
          context.commit('headers', response.headers);
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
        .post('/api/v1/auth/sign_in', {email: "guest@sample.com", password: "password"})
        .then(function (response) {
          context.commit('currentUser', { user: response.data.data });
          context.commit('headers', response.headers)
        })
        .catch(function (error) {
          alert(error);
        })
      context.commit('sampleLogined')
    },
    setCurrentUser(context, userParams) {
      context.commit('currentUser', { user: userParams })
    },
    setHeaders(context, headersParams) {
      context.commit('headers', headersParams)
    }
  },

})
