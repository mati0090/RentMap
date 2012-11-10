$ ->
  mapOptions = {"center": "51.10654,17.040825", "zoom": 14}
  map = $("#map_canvas").gmap(mapOptions);

  map.bind 'init', ->
    $.getJSON 'offers', (markers) ->
      markers.forEach (marker) ->
        map.gmap('addMarker', {'position': new google.maps.LatLng(marker.latitude, marker.longitude), 'bounds': false})