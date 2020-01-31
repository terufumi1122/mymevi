<template>
  <v-container>
    <v-row>
      <v-spacer></v-spacer>
      <v-card id="target" :style="{width: mapWidth + 'px', height: mapHeight + 'px'}"></v-card>
      <v-spacer></v-spacer>
    </v-row>
    <SpeedDial
      mainIcon="mdi-google-maps"
      icon1="mdi-map-marker-radius"
      color1="blue"
      :click1="setCurrentLocation"
      icon2="mdi-map-marker-multiple"
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
      icon: null,
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
    ...mapGetters([
      'currentUser',
      'locations'
    ]),
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
        this.icon = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png' //デフォルトは赤

        if (this.currentUser !== null ){
          if (location.user_id === this.currentUser.id) {
            this.icon = 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png' //currentUser用のアイコンをここで定義
          }
        }
        new google.maps.Marker({
          position: {
            lat: location.lat,
            lng: location.lng
          },
          icon: this.icon,
          map: this.map,
          animation: google.maps.Animation.DROP
        });
        console.log(location);
      });
      this.createFlash({ type: "success", message: "みんなのMy定番スポットをマッピングしました！" })
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

      //描画するためのmapを新規作成
      this.map = new google.maps.Map(target, mapOptions);

      // クリックしたらマーカーを配置し、位置情報をDB記録

      //mapをクリックしたときの動作を定義
      this.map.addListener("click", e => {
          this.getAddress(e) //緯度経度から文字列の住所に変換して情報を取得する
          setTimeout(() => {
            this.addMarker(e) //マーカーを追加する
            this.setLocationParams(e) //DBに位置情報を保存する
          }, 500) //500msで動作支障なし ※要変更
      });
    },

    setCurrentLocation() {
      //Geolocationが使えないブラウザであればアラートを出す。
      if (!navigator.geolocation) {
        alert("Geolocation not supported!");
        return;
      }
      console.log('setCurrentLocation()を開始します。') //後で消す
      //現在位置の取得を行う
      navigator.geolocation.getCurrentPosition(
        position => {
          //Vueコンポーネントのcenterに現在位置を代入
          this.center = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          };
          console.log(this.center); //後で消す

          this.map.panTo(this.center) //現在位置にmapの表示位置を移動させる
          new google.maps.Marker({
            position: this.center,
            map: this.map,
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
    },

    //以下、長くなるので切り出した関数

    getAddress(e) {
        new google.maps.Geocoder().geocode({ location: e.latLng },
        (results, status) => {
          const regExp = /〒\d{3}-\d{4} (.+)/
        const address = (results[0].formatted_address).match(regExp)
        console.log(status)
        if (status !== "OK") {
          alert("Failed: " + status);
          return;
        }
        // 該当位置の住所：results[0].formatted_address
        if (results[0]) {
          // this.address = results[0].formatted_address;
          this.address = address[1];
          console.log(`this.addressは`)
          //検証用
          console.log(this.address);
        } else {
          alert("No results!");
          return;
        }
      })
    },
    addMarker(e) {
        //マーカーを定義する
        let marker = new google.maps.Marker({
          position: e.latLng,
          map: this.map,
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
    },
    setLocationParams(e) {
        if (this.currentUser) {
          //位置情報を記録するために変数を宣言
        console.log(`currentUserは${this.currentUser}です`)
        let locationParams = {
          name: this.address,
          lat: e.latLng.lat(),
          lng: e.latLng.lng(),
          user_id: this.currentUser.id,
          habit_id: 0
        };
        console.log(`locationParamsは${locationParams}です`)
        console.log(locationParams)

        if (locationParams.name === null) {
          alert('住所情報の取得に失敗しました。処理を中断します。')
          return
        }
        //location.jsで定義したactionsを呼び出す。
        this.addLocation(locationParams);
      }
    }
  }
};
</script>

<style>
.zzz {
  z-index: 1000;
}
</style>