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

    <div class="input__button--fixed">
      <input type="text" id="keyword">
      <button id='search'>検索する</button>
    </div>

    <SearchBox
      @search="searchPoint"
      @gps="gps"
      @change-radius="dialog = true"
      class="input__button--fixed"
    ></SearchBox>

    <Slider
      :dialog="dialog"
      @close-dialog="dialog = false"
      title="検索範囲を変更 半径(m)を選んで下さい"
      :max="max"
      :min="min"
      @end="slider"
    ></Slider>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import SpeedDial from "./SpeedDial";
import InfoWindow from "./InfoWindow";
import SearchBox from "./SearchBox";
import Slider from "./Slider"

export default {
  name: "GoogleMap",
  components: {
    SpeedDial,
    InfoWindow,
    SearchBox,
    Slider,
  },
  data() {
    return {
      radius: 500,
      dialog: false,
      max: 5000,
      min: 500,
      buttons: [
        {id: 1, rouded: true, fab: false, color: "blue", click: "setCurrentLocation", icon: "mdi-map-marker-radius", text: "現在地を保存"},
        {id: 2, rouded: true, fab: false, color: "teal", click: "setMarker", icon: "mdi-map-marker-multiple", text: "みんなの場所を表示"},
        {id: 3, rouded: true, fab: false, color: "red", click: "deletePoint", icon: "mdi-delete", text: "登録地点を削除"},
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
    this.mapHeight = window.innerHeight - 112;
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
      if ( action === "setCurrentLocation" ) {
        this.setCurrentLocation()
      } else if ( action === "setMarker" ) {
        this.setMarker()
      } else if ( action === "deletePoint" ) {
        this.deletePoint()
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

    //現在位置に移動するメソッド
    gps() {
      //geolocationが使えるか確認
      if (!navigator.geolocation) {
        alert("Geolocation not supported!");
        return;
      }
      console.log('gps()を開始します。') //後で消す
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
        }
      );
    },

    slider(value) {
      console.log(`sliderから${value}を受け取りました`) //後で消す
      this.radius = value
      console.log(this.radius) //後で消す
    },

    searchPoint(keyword) {
      console.log('検索します')//後で消す
      console.log(keyword)//後で消す

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
            results.forEach( result => {
              console.log(result)
              new google.maps.Marker({
                map: this.map,
                position: result.geometry.location,
                title: result.name,
                icon: {
                  fillColor: "#990011",
                  fillOpacity: 0.7,
                  path: google.maps.SymbolPath.CIRCLE,
                  scale: 16,
                  strokeColor: "#fff",
                  strokeWeight: 1.0
                },
                label: {
                  text: 'New',
                  color: '#fff',
                  fontSize: '10px'
                }
              })
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
        // this.icon = 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png' //自分以外は青
        this.icon = {
            fillColor: "#0f4c81",
            fillOpacity: 0.7,
            path: google.maps.SymbolPath.CIRCLE,
            scale: 16,
            strokeColor: "#fff",
            strokeWeight: 1.0
        }
        this.label = {
          text: 'Others',
          color: '#fff',
          fontSize: '8px'
        }

        if (this.currentUser !== null ){
          if (isCurrentUser) {
            // this.icon = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png' //currentUserは赤
            this.icon = {
                fillColor: "#990011",
                fillOpacity: 0.7,
                path: google.maps.SymbolPath.CIRCLE,
                scale: 16,
                strokeColor: "#fff",
                strokeWeight: 1.0
            }
            this.label = {
              text: 'Yours',
              color: '#fff',
              fontSize: '8px'
            }
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
              habit_id: 30 //サンプル
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

    //自分がクリック or タップしたらマーカーを表示し、DBに位置情報を保存する
    addMarker(e) {
      console.log('addMarkerを開始します')
        //マーカーを定義する
        let marker = new google.maps.Marker({
          currentUser: true,
          id: (this.markers.length + 1),
          position: e.latLng,
          map: this.map,
          title: this.address,
          animation: google.maps.Animation.DROP,
          icon: {
            fillColor: "#990011",
            fillOpacity: 1.0,
            path: google.maps.SymbolPath.CIRCLE,
            scale: 16,
            strokeColor: "#fff",
            strokeWeight: 1.0
          },
          label: {
            text: 'New',
            color: '#fff',
            fontSize: '10px'
          }
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
.input__button--fixed {
  z-index: 1000;
  position: fixed;
  bottom: 80px;
  left: 10px;
}
/* .slider--fixed {
  z-index: 1000;
  position: fixed;
  bottom: 50px;
  left: 10px;
  width: 60%;
} */
</style>