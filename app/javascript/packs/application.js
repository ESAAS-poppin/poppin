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
window.initMapPage = function(lat, lng, items) {
    var myCoords = new google.maps.LatLng(lat, lng);
    var mapOptions = {
    center: myCoords,
    zoom: 8
    };
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);
    
    var marker = new google.maps.Marker({
        position: myCoords,
        map: map
    });
}

