export default ({

  state: {
    flash: null,
  },

  getters: {
    flash(state) {
      return state.flash;
    }
  },

  mutations: {


    //Common

    deleteFlash(state) {
      state.flash = null;
    },
    

    //User

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


    //Habit

    flashCreateHabit(state) {
      state.flash = {
        "type": "success", //Vuetifyのv-alertのオプションに合わせて設定
        "message": "新しい習慣を登録しました",
      };
    },
  },

})
