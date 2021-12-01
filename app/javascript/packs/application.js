// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

//= require_tree .

Rails.start()
Turbolinks.start()
ActiveStorage.start()

window.initMap = function(lat, lng) {
    var myCoords = new google.maps.LatLng(lat, lng);
    var mapOptions = {
    center: myCoords,
    zoom: 14
    };
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);

    var marker = new google.maps.Marker({
        position: myCoords,
        map: map
    });
}
window.initMultiMapPage = function InitMultiMap(events) {
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 15,
        center: new google.maps.LatLng(40.8033668, -73.9638017),
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    var infowindow = new google.maps.InfoWindow();
    var marker, i;
    let marker_positions = []
    for (i = 0; i < events.length; i++) {
        if (marker_positions.includes(events[i][2].toString() + "," + events[i][3].toString()))  {
            continue;
        }
        marker = new google.maps.Marker({
            position: new google.maps.LatLng(events[i][2], events[i][3]),
            map: map
        });
        marker_positions.push(events[i][2].toString() + "," + events[i][3].toString())
        google.maps.event.addListener(marker, 'click', (function (marker, i) {
            return function () {
                infowindow.setContent(events[i][0] +" @ "+ events[i][1]);
                infowindow.open(map, marker);
            }
        })(marker, i));
    }
}

