import axios from 'axios'

export default ({

  state: {
    locations: [],
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
        .then(response => {
          context.commit('addLocation', { location: response.data })
          context.commit('currentLocation', { location: response.data })
        })
        .catch(error => {
          console.error(error);
          alert(error);
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
          alert(error);
        })
    }
  }

})