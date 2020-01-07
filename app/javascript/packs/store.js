import 'babel-polyfill'
import Vue from 'vue'
import Vuex from 'vuex'

// import userStore from './stores/user.js'
import axios from 'axios'

Vue.use(Vuex)

const store = new Vuex.Store({

  modules: {
    // userStore,
  },

  state: {
    currentUser: null,
    headers: null,
    flash: null,
    habits: null,
  },

  getters: {
    currentUser(state) {
      return state.currentUser;
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
    },
    flashSignUp(state) {
      state.flash = {
        "type": "success", //Vuetifyのv-alertのオプションに合わせて設定
        "message": "新規登録・ログインに成功しました",
      };
    },
    flashSignIn(state) {
      state.flash = {
        "type": "success", //Vuetifyのv-alertのオプションに合わせて設定
        "message": "ログインに成功しました",
      };
    },
    flashSignOut(state) {
      state.flash = {
        "type": "info", //Vuetifyのv-alertのオプションに合わせて設定
        "message": "ログアウトに成功しました",
      };
    },
    flashUpdateUser(state) {
      state.flash = {
        "type": "success", //Vuetifyのv-alertのオプションに合わせて設定
        "message": "ユーザー情報を更新しました",
      };
    },
    flashDeleteUser(state) {
      state.flash = {
        "type": "warning", //Vuetifyのv-alertのオプションに合わせて設定
        "message": "アカウントを削除しました",
      };
    },
    deleteFlash(state) {
      state.flash = null;
    },
    currentUserHabits(state, payload) {
      state.habits = payload.habits
    }
  },

  actions: {
    signUp(context, userParams) {
      axios
        .post('/api/v1/auth', userParams)
        .then(function (response) {
          context.commit('currentUser', { user: response.data });
          context.commit('signIn', response.headers);
          context.commit('flashSignUp');
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
          context.commit('flashSignIn');
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
          context.commit('flashSignOut');
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
          context.commit('flashUpdateUser');
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
        context.commit('flashDeleteUser');
      })
      .catch(function (error) {
        alert(error);
      })
    },

    setCurrentUserHabits(context, currentUserId) {
      axios
        .get('/api/v1/habits', { params: { user_id: currentUserId } })
        .then(function (response) {
          context.commit('currentUserHabits', { habits: response.data })
        })
        .catch(function (error) {
          alert(error)
        })
    }
  },

})

export default store