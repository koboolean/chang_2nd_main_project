var map, marker;
var markers = [];


function createMap(){
    map = new Tmapv2.Map("map_div", {
        center : new Tmapv2.LatLng(33.4794947,126.4919039),
        width : "100%",
        height : "100%",
        zoom : 15,
        zoomControl : true,
        scrollwheel : true
    
    });

    markerReset();

}
function markerReset(){
    // 마커 초기화
    marker = new Tmapv2.Marker({
        map:map
    });
}
ß
function currentLocation(lat, lon){
    marker.setMap(null);
    var markerPosition = new Tmapv2.LatLng(lat, lon);

    marker = new Tmapv2.Marker({
        position : markerPosition,
        map:map
    });
    map.setCenter(markerPosition);
    markers.push(marker);
}

