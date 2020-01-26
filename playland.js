map.addListener('click', function (e) {
  geocoder.geocode({
    location: e.latLng
  }, function (results, status) {
    if (status !== 'OK') {
      alert('Failed: ' + status);
      return;
    }
    // results[0].formatted_address
    if (results[0]) {
      new google.maps.Marker({
        position: e.latLng,
        map: map,
        title: results[0].formatted_address,
        animation: google.maps.Animation.DROP
      });
    } else {
      alert('No results found');
      return;
    }
  });
});

// Promise

function getName() {
  setTimeout(() => {
    console.log("Johndoe");
  }, 2000);
}
getName();

function getName2() {
  return new Promise(resolve => {
    setTimeout(() => {
      resolve("iini");
    }, 2000);
  });
}
getName2()
  .then(name => {
  console.log(name);
    return 20;
  })
  .then(getAge)
  .then((age) => {
    console.log(age);
})

// let func_one = function (callback) {
//   console.log("The first ...");
//   if (callback) {
//     callback();
//   }
// };
// let func_second = function (callback) {
//   console.log("The second ...");
//   if (callback) {
//     callback();
//   }
// };
// let func_third = function (callback) {
//   console.log("... and the third!!!");
//   if (callback) {
//     callback();
//   }
// };

// func_one(function () {
//   func_second(function () {
//     func_third();
//   });
// });

// func_one();
// func_second();
// func_third();

// const locations = [
//   {lat: 22.222, lng: 44.555},
//   {lat: 22.222, lng: 44.555},
//   {lat: 22.222, lng: 44.555},
//   {lat: 22.222, lng: 44.555},
//   {lat: 22.222, lng: 44.555},
//   {lat: 22.222, lng: 44.555},
// ]

// locations.forEach((location) => {
//   new google.maps.Marker({
//     position: {
//       lat: location.lat,
//       lng: location.lng,
//     },
//     map: this.map,
//   })
// })