// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import Vue from 'vue'
import App from '../app.vue'

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    render: (h) => h(App)
  })
})

window.Event = new class {

  constructor() {
    this.vue = new Vue();
  }

  fire(event, data = null, action) {
    this.vue.$emit(event, data, action);
  }

  listen(event, callback) {
    this.vue.$on(event, callback)
  }

}

var infoWindowButton = Vue.extend({
  template: '<button type="button" @click="infoWindowButtonClicked()">This is a button</button></div>',
  methods: {
    infoWindowButtonClicked: function () {
      Event.fire('infoWindowButtonClicked');
    }
  }
})
Event.fire('infoWindowButton', new infoWindowButton().$mount()); 

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
