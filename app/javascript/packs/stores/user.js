// export default {

//   state: {
//     headers: {
//       "uid": '',
//       "access-token": '',
//       "client": '',
//     },
//   },

//   getters: {
//     headers(state) {
//       return state.headers
//     },
//   },

//   mutations: {
//     signIn(state, payload) {
//       state.headers = {
//         "access-token": payload["access-token"],
//         "client": payload["client"],
//         "uid": payload["uid"],
//       };
//     },
//     signOut(state) {
//       state.headers = null;
//     },
//   },

//   actions: {
//     signIn(context, userParams) {
//       axios
//         .post('/api/auth/sign_in', userParams)
//         .then(function (response) {
//           context.commit('signIn', response.headers )
//         })
//     }
//   }
// }