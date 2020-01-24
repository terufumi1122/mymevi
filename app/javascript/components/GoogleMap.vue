<template>
  <v-container>
    <v-row>
      <v-spacer></v-spacer>
      <div
        id="target"
        :style="{width: mapWidth + 'px', height: mapHeight + 'px'}"
      ></div>
      <v-spacer></v-spacer>
    </v-row>
  </v-container>
</template>

<script>

  export default {
    name: 'GoogleMap',
    data(){
      return {
        map: null,
        marker: null,
        // 東京の緯度経度
        center: {
          lat: 35.658230,
          lng: 139.701642
        },
        zoom: 12,
        mapWidth: 300,
        mapHeight: 300,
        infoWindow: '',
      }
    },
    created() {
      this.mapWidth = window.innerWidth - 50;
      this.mapHeight = window.innerHeight - 150;
    },
    mounted() {
      this.createMap()
    },
    methods: {
      createMap() {
        const target = document.getElementById("target");
        const mapOptions = { 
          center: this.center,
          zoom: this.zoom,
          disableDefaultUI: true,
          zoomControl: true
        };
        this.map = new google.maps.Map(target, mapOptions);

        this.map.addListener('click', (e) => {
          this.marker = new google.maps.Marker({
            position: e.latLng,
            map: this.map,
            title: e.latLng.toString(),
            animation: google.maps.Animation.DROP
          })
        })
        //   marker.addListener('click', function() {
        //     this.setMap(null)
        //   })

        // infoWindow = new google.maps.InfoWindow({
        //   position: tokyo,
        //   content: 'HELLO!!!!HELLO!!!!HELLO!!!!HELLO!!!!'
        // });

        // infoWindow.open(map);
      }
    }
  }
</script>

<style>
</style>