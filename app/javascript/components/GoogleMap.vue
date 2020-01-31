<template>
  <div>
      <v-card id="target" :style="{width: mapWidth + 'px', height: mapHeight + 'px'}"></v-card>

    <div v-for="marker in markers" :key="marker.id">
      <InfoWindow
        :id="marker.id"

        :isCurrentUser="marker.currentUser"
        title="あなたが登録した場所です！"
        :address="marker.title"

        color1="blue"
        icon1="mdi-link-variant"
        routeTo1=""
        routeToText1="自分の習慣を紐付ける"
        @clickButton1="sampleAlert"

        color2="red"
        icon2='mdi-delete'
        routeTo2=""
        routeToText2="削除する"
        @clickButton2="deletePoint"
      ></InfoWindow>
    </div>

    <SpeedDial
      mainIcon="mdi-google-maps"
      :buttons="buttons"
      @click-button="triggerClick"
      class="zzz"
    ></SpeedDial>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import SpeedDial from "./SpeedDial";
import InfoWindow from "./InfoWindow";

export default {
  name: "GoogleMap",
  components: {
    SpeedDial,
    InfoWindow,
  },
  data() {
    return {
      buttons: [
        {id: 1, rouded: true, fab: false, color: "blue", click: "setCurrentLocation", icon: "mdi-map-marker-radius", text: "現在地をセット"},
        {id: 2, rouded: true, fab: false, color: "teal", click: "setMarker", icon: "mdi-map-marker-multiple", text: "みんなの場所を表示"},
        {id: 3, rouded: true, fab: false, color: "red", click: "deletePoint", icon: "mdi-delete", text: "登録地点を削除"},
      ],
      user_id: null,
      map: null,
      markers: [],
      address: null,
      icon: null,
      center: { //東京の緯度経度
        lat: 35.65823,
        lng: 139.701642
      },
      zoom: 12,
    };
  },
  computed: {
    ...mapGetters([
      'currentUser',
      'locations',
      'currentLocation'
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
    this.mapWidth = window.innerWidth;
    this.mapHeight = window.innerHeight - 500;
    // this.mapHeight = window.innerHeight - 112;
    this.setLocations();
  },
  mounted() {
    this.createMap();
  },
  methods: {
    ...mapActions([
      'addLocation',
      'setLocations',
      'deleteLocation',
      'createFlash'
      ]),

    triggerClick(action) {
      console.log(`引数actionは${action}です`)
      if ( action === "setCurrentLocation" ) {
        this.setCurrentLocation()
      } else if ( action === "setMarker" ) {
        this.setMarker()
      } else if ( action === "deletePoint" ) {
        this.deletePoint()
      }
    },

    sampleAlert() {
      alert('いいに！')
    },

    sampleMethod(arg) {
      console.log(arg)
    },

    deletePoint() {
      console.log('delete it!!')
      // this.deleteLocation(locationId)
    },

    setMarker() {
      //for文で、state.locationsにあるデータをマッピング
      this.locations.forEach(location => {
        let isCurrentUser = location.user_id === this.currentUser.id

        //アイコンの色をログイン中のユーザーかどうかで変更
        this.icon = 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png' //自分以外は青
        if (this.currentUser !== null ){
          if (isCurrentUser) {
            this.icon = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png' //currentUserは赤
          }
        }

        let marker = new google.maps.Marker({
          currentUser: isCurrentUser,
          id: (this.markers.length + 1),
          position: {
            lat: location.lat,
            lng: location.lng
          },
          icon: this.icon,
          map: this.map,
          title: location.name,
          animation: google.maps.Animation.DROP
        });
        this.markers.push(marker)
        //時間差がないとうまく反映されなかったためやむなくsetTimeoutで調整
        setTimeout(()=>{
        //マーカーをクリックしたときのウインドウに表示する内容を定義する
          let infoWindow = new google.maps.InfoWindow({
            content: document.getElementById(marker.id)
          });
          //マーカーをクリックしたらウインドウが開くようにする
          marker.addListener("click", () => {
            infoWindow.open(this.map, marker);
          });
        },1000)
      })
      this.createFlash({ type: "success", message: "みんなのMy定番スポットをマッピングしています..." })
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
        if (status !== "OK") {
          alert("Failed: " + status);
          return;
        }
        // 該当位置の住所：results[0].formatted_address
        if (results[0]) {
          // this.address = results[0].formatted_address;
          this.address = address[1];
        } else {
          alert("No results!");
          return;
        }
      })
    },
    addMarker(e) {
      console.log('addMarkerを開始します')
        //マーカーを定義する
        let marker = new google.maps.Marker({
          currentUser: true,
          id: (this.markers.length + 1),
          position: e.latLng,
          map: this.map,
          title: this.address,
          animation: google.maps.Animation.DROP
        });
        console.log(marker)
        this.markers.push(marker)
        // コンポーネント内dataのmarkersに上記を加える
        // 時間差がないとうまく反映されなかったためやむなくsetTimeoutで調整
        setTimeout(()=>{
          //マーカーをクリックしたときのウインドウに表示する内容を定義する
          let infoWindow = new google.maps.InfoWindow({
            content: document.getElementById(marker.id)
          });
          //マーカーをクリックしたらウインドウが開くようにする
          marker.addListener("click", () => {
            infoWindow.open(this.map, marker);
          });
        }, 2000)
    },
    setLocationParams(e) {
      console.log('setLocationParamsを開始します')
        if (this.currentUser) {
          //位置情報を記録するために変数を宣言
        let locationParams = {
          name: this.address,
          lat: e.latLng.lat(),
          lng: e.latLng.lng(),
          user_id: this.currentUser.id,
          habit_id: 0
        };

        if (locationParams.name === null) {
          alert('住所情報の取得に失敗しました。処理を中断します。')
          return
        }
        //location.jsで定義したactionsを呼び出す。
        this.addLocation(locationParams);

      }
    },
  }
};
</script>

<style>
.zzz {
  z-index: 1000;
}
</style>