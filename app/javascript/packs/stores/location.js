import axios from 'axios'

export default ({

  state: {
    locations: null,
    currentLocation: null,
  },

  getters: {
    locations(state) {
      return state.locations;
    },
    currentLocation(state) {
      return state.currentLocation;
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
        .then(function (response) {
          context.commit('addLocation', { location: response.data })
          context.commit('currentLocation', { location: response.data })
        })
        .catch(function (error) {
          console.error(error);
          alert(error);
        })
    }
  }

})