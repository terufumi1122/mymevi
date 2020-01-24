<script>
    function initMap() {
      "use strict";
  
      const target = document.getElementById("target");
      // const geocoder = new google.maps.Geocoder();
      let map;
      const tokyo = { lat: 35.681167, lng: 139.767052 };
      // let service;
      // Geocoding
      // Reverse Geocoding
  
      map = new google.maps.Map(target, {
        center: tokyo,
        zoom: 15
      });
  
      // if (!navigator.geolocation) {
      //   alert("Geolocation not supported");
      //   return;
      // }
      // navigator.geolocation.getCurrentPosition(
      //   function(position) {
      //     new google.maps.Map(target, {
      //       center: {
      //         lat: position.coords.latitude,
      //         lng: position.coords.longitude
      //       },
      //       zoom: 15
      //     });
      //   },
      //   function() {
      //     alert("Geolocation failed!");
      //     return;
      //   }
      // );
  
      // document.getElementById('search').addEventListener('click', function() {
      //   service = new google.maps.places.PlacesService(map);
      //   service.nearbySearch({
      //     location: tokyo,
      //     radius: '500',
      //     name: document.getElementById('keyword').value
      //   }, function(results, status){
      //     let i;
      //     if (status === google.maps.places.PlacesServiceStatus.OK){
      //       for (i = 0; i < results.length; i++) {
      //         new google.maps.Marker({
      //           map: map,
      //           position: results[i].geometry.location,
      //           title: results[i].name
      //         });
      //       }
      //     } else {
      //       alert('Failed: ' + status);
      //       return;
      //     }
      //   })
      // })
  
      // map.addListener('click', function(e) {
      //   geocoder.geocode({
      //     location: e.latLng
      //   }, function(results, status) {
      //     if (status !== 'OK'){
      //       alert('Failed: ' + status);
      //       return;
      //     }
      //     if (results[0]){
      //       new google.maps.Marker({
      //         position: e.latLng,
      //         map: map,
      //         title: results[0].formatted_address,
      //         animation: google.maps.Animation.DROP
      //       });
      //     } else {
      //       alert('No results found');
      //       return;
      //     }
      //   })
      // })
  
      // document.getElementById('search').addEventListener('click', function(){
      //   geocoder.geocode({
      //     address: document.getElementById('address').value
      //   }, function(results, status) {
      //     if (status !== 'OK'){
      //       alert('Failed: ' + status);
      //       return;
      //     }
      //     if (results[0]) {
      //       new google.maps.Map(target, {
      //         center: results[0].geometry.location,
      //         zoom: 15
      //       })
      //     } else {
      //       alert('No results found');
      //       return;
      //     }
      //   })
      // })
  
      // const tokyo = { lat: 35.681236, lng: 139.767125 };
      // let map;
      // // let marker;
      // let infoWindow;
  
      // map = new google.maps.Map(target, {
      //   center: tokyo,
      //   zoom: 15,
      //   // disabledDefaultUI: true,
      //   // zoomControl: true,
      //   // mapTypeId: 'hybrid',
      //   // clickableIcons: false,
      // });
  
      // map.addListener('click', function(e) {
      //   let marker = new google.maps.Marker({
      //     position: e.latLng,
      //     map: this,
      //     animation: google.maps.Animation.DROP
      //   });
      //   let infoWindow = new google.maps.InfoWindow({
      //     content: e.latLng.toString()
      //   });
      //   marker.addListener('click', function() {
      //     infoWindow.open(map, marker);
      //   })
      // })
  
      // infoWindow = new google.maps.InfoWindow({
      //   position: tokyo,
      //   content: document.getElementById('info'),
      //   maxWidth: 100
      // });
  
      // infoWindow.open(map);
  
      // marker = new google.maps.Marker({
      //   position: tokyo,
      //   map: map,
      //   title: 'Tokyo!',
      //   // icon: 'icon.png',
      //   // icon: {
      //   //   url: 'icon.png',
      //   //   scaledSize: new google.maps.Size(24, 24)
      //   // },
      //   animation: google.maps.Animation.DROP
      // });
  
      // map.addListener('click', function(e) {
      //   let marker = new google.maps.Marker({
      //     position: e.latLng,
      //     map: map,
      //     title: e.latLng.toString(),
      //     animation: google.maps.Animation.DROP
      //   });
      //   marker.addListener('click', function() {
      //     this.setMap(null)
      //   });
      // });
  
      //   console.log(e.latLng.lat());
      //   console.log(e.latLng.lng());
      //   console.log(e.latLng.toString());
      //   // this.setCenter(e.latLng);
      //   this.panTo(e.latLng);
      // })
    }
</script>