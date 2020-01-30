<template>
  <v-container>
    <v-row>
      <v-spacer></v-spacer>
      <v-card id="target" :style="{width: mapWidth + 'px', height: mapHeight + 'px'}"></v-card>
      <v-spacer></v-spacer>
    </v-row>
    <SpeedDial
      mainIcon="mdi-google-maps"
      icon1="mdi-map-marker-plus"
      color1="blue"
      :click1="setCurrentLocation"
      icon2="mdi-map-marker"
      color2="teal"
      :click2="setMarker"
      icon3="mdi-delete"
      color3="red"
      :click3="setMarker"
      class="zzz"
    ></SpeedDial>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import SpeedDial from "./SpeedDial";

export default {
  name: "GoogleMap",
  components: {
    SpeedDial
  },
  data() {
    return {
      user_id: null,
      map: null,
      marker: null,
      address: null,
      // 東京の緯度経度
      center: {
        lat: 35.65823,
        lng: 139.701642
      },
      zoom: 12,
      mapWidth: 300,
      mapHeight: 300,
      infoWindow: ""
    };
  },
  computed: {
    ...mapGetters(["currentUser", "locations"]),
    allLocations() {
      return this.locations;
    },
    currentUserLocations() {
      return this.locations.filter(
        location => location.user_id === this.currentUser.id
      );
    }
  },
  created() {
    this.mapWidth = window.innerWidth - 50;
    this.mapHeight = window.innerHeight - 150;
    this.setLocations();
  },
  mounted() {
    this.createMap();
  },
  methods: {
    ...mapActions([
      'addLocation',
      'setLocations',
      'createFlash'
      ]),
    setMarker() {
      console.log("これからマーカー配置です");
      //for文で、state.locationsにあるデータをマッピング
      this.locations.forEach(location => {
        new google.maps.Marker({
          position: {
            lat: location.lat,
            lng: location.lng
          },
          map: this.map,
          animation: google.maps.Animation.DROP
        });
        console.log(location);
      });
      this.createFlash({ type: "success", message: "みんなのオススメスポットをマッピングしました！" })
      console.log("マーカー配置実行直後の行です");
    },

    createMap() {
      const target = document.getElementById("target");
      const mapOptions = {
        center: this.center,
        zoom: this.zoom,
        disableDefaultUI: true,
        zoomControl: true
      };
      this.map = new google.maps.Map(target, mapOptions);
      let geocoder = new google.maps.Geocoder();

      // クリックしたらマーカーを配置し、位置情報をDB記録
      this.map.addListener("click", e => {
        //Geocoderで緯度経度を住所に変換する
        geocoder.geocode(
          {
            location: e.latLng
          },
          (results, status) => {
            if (status !== "OK") {
              alert("Failed: " + status);
              return;
            }
            // 該当位置の住所：results[0].formatted_address
            if (results[0]) {
              this.address = results[0].formatted_address;
              //検証用
              console.log(this.address);
            } else {
              alert("No results!");
              return;
            }
          }
        );
        //マーカーを定義する
        let marker = new google.maps.Marker({
          position: e.latLng,
          map: this.map,
          // title: e.latLng.toString(),
          title: this.address,
          animation: google.maps.Animation.DROP
        });
        //マーカーをクリックしたときのウインドウに表示する内容を定義する
        let infoWindow = new google.maps.InfoWindow({
          content: e.latLng.toString()
        });
        //マーカーをクリックしたらウインドウが開くようにする
        marker.addListener("click", () => {
          infoWindow.open(this.map, marker);
        });

        //動作確認用（最終的には消す）
        console.log(e.latLng);
        console.log(e.latLng.lat());
        console.log(e.latLng.lat().toString());

        if (this.currentUser) {
          //位置情報を記録するために変数を宣言
          let locationParams = {
            // name: e.latLng.toString(),
            name: this.address,
            lat: e.latLng.lat(),
            lng: e.latLng.lng(),
            user_id: this.currentUser.id,
            habit_id: 0
          };
          //location.jsで定義したactionsを呼び出す。
          this.addLocation(locationParams);
        }
      });
    },

    setCurrentLocation() {
      //Geolocationが使えないブラウザであればアラートを出す。
      if (!navigator.geolocation) {
        alert("Geolocation not supported!");
        return;
      }

      //現在位置の取得を行う
      navigator.geolocation.getCurrentPosition(
        position => {
          //Vueコンポーネントのcenterに現在位置を代入
          this.center = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          };
          console.log(this.center);
          // 新しいMapを描画する
          let currentMap = new google.maps.Map(target, {
            center: this.center,
            zoom: 15
          });
          new google.maps.Marker({
            position: this.center,
            map: currentMap,
            title: "現在位置",
            animation: google.maps.Animation.DROP
          });

          //ログイン後は位置情報を記録する
          if (this.currentUser) {
            //位置情報を記録するために変数を宣言
            let locationParams = {
              name: this.address,
              lat: this.center.lat,
              lng: this.center.lng,
              user_id: this.currentUser.id,
              habit_id: 0
            };
            //location.jsで定義したactionsを呼び出す。
            this.addLocation(locationParams);
          }
        },
        function() {
          alert("Geolocation failed!");
          return;
        }
      );
    }
  }
};
</script>

<style>
.zzz {
  z-index: 1000;
}
</style>