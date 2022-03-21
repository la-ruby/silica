import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "marker" ]

  initMap() {
    var imgArr =   [{
        url: 'https://raw.githubusercontent.com/googlemaps/v3-utility-library/master/markerclusterer/images/conv40.png',
        height: 55,
        width: 90,
        anchor: [6, 0],
        textColor: '#fff',
        textSize: 10,
        backgroundPosition:'center',
    }];
    var markerCenter = new google.maps.LatLng(40.7607808, -111.8911171);
    var mapOptions = {
      zoom: 7,
      center: markerCenter,
      disableDefaultUI: true,
      gestureHandling: 'greedy'
    };
    var map = new google.maps.Map(document.getElementById('apollo-map-inner'),
            mapOptions);
    var markersArr = [];

    for (var i = 0; i < this.markerTargets.length; i++) {
      var item = this.markerTargets[i];
      var infowindow = new google.maps.InfoWindow();
      var marker = new MarkerWithLabel({
        draggable: false,
        raiseOnDrag: false,
        icon: ' ',
        map: map,
        labelContent: '<span>'+ $(item).data('label') + '</span>',
        labelAnchor: new google.maps.Point(40,32),
        labelClass: "map-label", // the CSS class for the label
        labelStyle: {opacity: 1},
        position: {lat: $(item).data('lat'), lng: $(item).data('lng')},
        data: $(item).data('label2'),
        dataPrice: 'BAZ'
      });
      markersArr.push(marker);
      marker.addListener('click', function() {
        infowindow.setContent( this.data );
        infowindow.open(map, this);
      });
    }
  }
  connect() {
    if (typeof google === 'object' && typeof google.maps === 'object') {
      this.initMap()
    } else {
      alert("Google Maps failed to load, possibly due to slow network")
    }
  }
}
