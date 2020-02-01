import axios from 'axios'

export default ({

  state: {
    locations: [],
    currentLocation: {},
  },

  getters: {
    locations(state) {
      return state.locations;
    },
    currentLocation(state) {
      return state.currentLocation;
    },
    habitLocation(state, getters) {
      if (getters.habitDetail.location_id) {
        return state.locations.find( location => location.id === getters.habitDetail.location_id)
      } else {
        return { name: '名もなき場所' }
      }
    }
  },

  mutations: {
    locations(state, payload) {
      state.locations = payload.locations
    },
    addLocation(state, payload) {
      state.locations.push(payload.location) 
    },
    currentLocation(state, payload) {
      state.currentLocation = payload.location
    },
  },

  actions: {

    addLocation(context, locationParams) {
      axios
        .post('/api/v1/locations', locationParams)
        .then(response => {
          context.commit('addLocation', { location: response.data })
          context.commit('currentLocation', { location: response.data })
        })
        .catch(error => {
          console.error(error);
          context.commit('createFlash', { type: 'error', message: '位置情報の登録に失敗しました'})
        })
    },
    
      setLocations(context) {
        axios
        .get('/api/v1/locations')
        .then(response => {
          context.commit('locations', { locations: response.data })
        })
        .catch(error => {
          console.error(error);
          context.commit('createFlash', { type: 'error', message: '登録済の位置情報のセットに失敗しました'})
        })
    },
      
    updateLocation(context, locationParams) {
      axios
        .patch(`/api/v1/locations/${locationParams.id}`, locationParams)
        .then(() => {
          context.commit('locations', { locations: response.data })
          context.commit('createFlash', { type: 'info', message: '位置情報を習慣に紐付けました'})
        })
        .catch(error => {
          console.error(error)
          context.commit('createFlash', { type: 'error', message: '位置情報を習慣に紐付けることが出来ませんでした'})
        })
    },

      //↓ロジックは完成しているが、locationIdの取り出し方がmap側から出来ておらず未完
      deleteLocation(context, locationId) {
        axios
        .delete(`/api/v1/locations/${locationId}`, locationId)
        .then(() => {
          context.commit('createFlash', { type: 'info', message: 'My定番スポットを削除しました'})
        })
        .catch(error => {
          console.error(error)
          context.commit('createFlash', { type: 'error', message: '位置情報の削除に失敗しました'})
        })
    }
  }

})