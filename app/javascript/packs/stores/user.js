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
    signUp(context, userParams, routeTo) {
      axios
        .post('/api/v1/auth', userParams)
        .then(response => {
          context.commit('currentUser', { user: response.data.data });
          context.commit('headers', response.headers);
          context.dispatch('createFlash', { type: 'success', message: '新規登録・ログインに成功しました' });
          return routeTo;
        })
        .catch(error => {
          console.error(error);
          context.dispatch('createFlash', { type: 'error', message: '新規登録・ログインに失敗しました' });
        });
    },
    signIn(context, userParams, routeTo) {
      axios
        .post('/api/v1/auth/sign_in', userParams)
        .then(response => {
          context.commit('currentUser', { user: response.data.data });
          context.commit('headers', response.headers);
          context.dispatch('createFlash', { type: 'success', message: 'ログインしました' });
          console.log('routeToの上です')
          console.log(routeTo)
          return routeTo;
        })
        .catch(error => {
          console.error(error);
          console.log('createFlashの上です')
          context.dispatch('createFlash', {type: 'error', message: 'ログインに失敗しました'})
          console.log('createFlashの下です')
        });
      },
      signOut(context, routeTo) {
        axios
        .delete('/api/v1/auth/sign_out', { headers: context.state.headers })
        .then(() => {
          context.commit('signOut');
          context.dispatch('createFlash', { type: 'info', message: 'ログアウトに成功しました' });
          return routeTo;
        })
        .catch(error => {
          context.dispatch('createFlash', {type: 'error', message: 'ログアウトに失敗しました'})
          console.error(error);
        })
      },
      updateUser(context, userParams, routeTo) {
        axios
        .put('/api/v1/auth', userParams, { headers: context.state.headers })
        .then(response => {
          context.commit('currentUser', { user: response.data.data });
          context.commit('headers', response.headers);
          context.dispatch('createFlash', { type: 'success', message: 'ユーザー情報を更新しました' });
          return routeTo;
        })
        .catch(error => {
          console.error(error);
          context.dispatch('createFlash', { type: 'error', message: 'ユーザー情報の更新に失敗しました' });
      })
    },
    deleteUser(context, routeTo) {
      axios
      .delete('/api/v1/auth', { headers: context.state.headers })
      .then(() => {
        context.commit('signOut');
        context.dispatch('createFlash', { type: 'warning', message: 'アカウントを削除しました' });
        return routeTo;
      })
      .catch(error => {
        console.error(error);
        context.dispatch('createFlash', { type: 'error', message: 'アカウントの削除に失敗しました' });
      })
    },
    sampleLogin(context, routeTo) {
      axios
      .post('/api/v1/auth/sign_in', {email: "guest@sample.com", password: "password"})
      .then(response => {
          context.commit('currentUser', { user: response.data.data });
          context.commit('headers', response.headers);
        context.dispatch('createFlash', { type: 'success', message: 'ゲストユーザーとしてログインしました' });
        return routeTo;
        })
        .catch(error => {
          context.dispatch('createFlash', { type: 'error', message: 'ゲストユーザーログインに失敗しました' });
          console.error(error);
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
