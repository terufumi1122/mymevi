//JavaScriptの構文が正しいかをQuakkaで検証するためのスペース

import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'GoogleMap',
  data() {
    return {
      user_id: null,
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
  computed: {
    ...mapGetters([
      'currentUser'
    ])
  },
  created() {
    this.mapWidth = window.innerWidth - 50;
    this.mapHeight = window.innerHeight - 150;
  },
  mounted() {
    this.createMap()
  },
  methods: {
    ...mapActions([
      'addLocation'
    ]),
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
        console.log(e.latLng)
        console.log(e.latLng.lat())
        console.log(e.latLng.lat().toString())

        const currentUser = {
          data: {
            id: 1,
            name: 'iini'
          }
        };

        if (currentUser) {
          //位置情報を記録するために変数を宣言
          let locationParams = {
            name: e.latLng.toString(),
            lat: e.latLng.lat(),
            lng: e.latLng.lng(),
            user_id: currentUser.data.id,
            habit_id: 0
          }
          //location.jsで定義したactionsを呼び出す。
          this.addLocation(locationParams);
        }
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