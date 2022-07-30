
function createMap(){
    map = new Tmapv2.Map("map_div", {
        center : new Tmapv2.LatLng(37.570028, 126.986072),
        width : "100%",
        height : "400px",
        zoom : 15,
        zoomControl : true,
        scrollwheel : true
    
    });

    //JavascriptChannel.postMessage(); 
    // JavascriptChannel( name: 'JavascriptChannel',  .....) 이름이 같아야함

}

function currentLocation(){
    map = null
    let latLocation = 33.4794947
    let lonLocation = 126.4919039
     map = new Tmapv2.Map("map_div",  
    {
        center: new Tmapv2.LatLng(latLocation,lonLocation), // 지도 초기 좌표
        width: "100%", 
        height: "570px",
        zoom: 15
    });
    
}