<template>
  <div>
      <v-card
        fixed
        id="target"
        :style="{width: mapWidth + 'px', height: mapHeight + 'px'}"
        ></v-card>

    <SpeedDial
      mainIcon="mdi-google-maps"
      :buttons="buttons"
      @click-button="triggerClick"
      class="zzz"
    ></SpeedDial>

    <SearchBox
      @search="searchPoint"
      class="search__box"
    ></SearchBox>

  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";

import SpeedDial from "./SpeedDial";
import SearchBox from "./SearchBox";

export default {
  name: "GoogleMap",
  components: {
    SpeedDial,
    SearchBox,
  },
  data() {
    return {
      zoom: 12,
      radiusPattern: [0,0,0,0,0,0,0,0,85000, 43000, 21600, 12300, 5500, 2800, 1300, 650, 340, 160, 90, 50],
      buttons: [
        {id: 1, rouded: true, fab: false, color: "blue", click: "gps", icon: "mdi-map-marker-radius", text: "現在地に移動"},
        {id: 2, rouded: true, fab: false, color: "teal", click: "setMarker", icon: "mdi-map-marker-multiple", text: "みんなの場所を表示"},
        {id: 3, rouded: true, fab: false, color: "red", click: "clearMarkers", icon: "mdi-map-marker-remove", text: "マーカー一括削除"},
      ],
      user_id: null,
      map: null,
      markers: [],
      address: null,
      icon: null,
      label: null,
      center: { //東京の緯度経度
        lat: 35.65823,
        lng: 139.701642
      },
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
    },
    radius() {
      return this.radiusPattern[this.zoom]
    }
  },
  created() {
    this.mapWidth = window.innerWidth;
    this.mapHeight = window.innerHeight - 112;
    this.setLocations();
    this.createFlash({type: "info", message: "現在β版です（ユーザーレビュー反映中）"})
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
      if ( action === "setCurrentLocation" ) {
        this.setCurrentLocation()
      } else if ( action === "setMarker" ) {
        this.setMarker()
      } else if ( action === "clearMarkers" ) {
        this.clearMarkers()
      }
    },

    sampleAlert() {
      alert('サンプルアラート')
    },

    sampleMethod(arg) {
      console.log(arg)
    },

    deletePoint() {
      console.log('delete it!!')
      // this.deleteLocation(locationId)
    },
    clearMarkers() {
      this.markers.forEach(m => m.setMap(null))
    },

    //現在位置に移動するメソッド
    gps() {
      //geolocationが使えるか確認
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
          this.map.panTo(this.center) //現在位置にmapの表示位置を移動させる
        }
      );
    },

    searchPoint(keyword) {

      if (keyword === '') {
        alert('住所やキーワードを入力して下さい')
        return
      }
      //検索
        new google.maps.places.PlacesService(this.map).nearbySearch({
          location: this.center,
          radius: this.radius,
          name: keyword
        }, (results, status) => {
          if (status === google.maps.places.PlacesServiceStatus.OK) {

            this.icon = 'http://maps.google.com/mapfiles/ms/icons/green-dot.png' //currentUserは赤
            results.forEach( result => {
              let marker = new google.maps.Marker({
                map: this.map,
                position: result.geometry.location,
                title: result.name,
                icon: this.icon
              })
              this.markers.push(marker)
            })
          } else if (status === "ZERO_RESULTS") {
            alert('検索結果が見つかりませんでした')
          }
        })
    },

    //現在登録済の位置情報を一括でマッピングする
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
          label: this.label,
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
      this.createFlash({ type: "success", message: "みんなの定番スポットを表示しました！" })
    },

    createMap() {
      const target = document.getElementById("target");
      const mapOptions = {
        gestureHandling: 'greedy',
        center: this.center,
        zoom: this.zoom,
        disableDefaultUI: true,
        zoomControl: true
      };

      //描画するためのmapを新規作成
      this.map = new google.maps.Map(target, mapOptions);
      this.map.addListener('center_changed', () => {
        this.center = this.map.getCenter()
        })
      this.map.addListener('zoom_changed', () => {
        this.zoom = this.map.getZoom()
        })
      this.markers = new google.maps.MVCArray()
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

    //自分がクリック or タップしたらマーカーを表示し、DBに位置情報を保存する
    addMarker(e) {
        //マーカーを定義する
        let marker = new google.maps.Marker({
          currentUser: true,
          id: (this.markers.length + 1),
          position: e.latLng,
          map: this.map,
          title: this.address,
          animation: google.maps.Animation.DROP,
        });
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
.search__box {
  z-index: 1000;
  position: fixed;
  bottom: 80px;
  right: 120px;
}
</style>