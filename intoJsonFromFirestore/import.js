const  firestoreService = require('firestore-export-import');
const firebaseConfig = require('./config.js');
const serviceAccount = require('./serviceAccount.json');
const nodeGeocoder = require('node-geocoder');
const path = require('path');

const options = {
    provider: 'google',
    apiKey: 'AIzaSyBzc-ETNDyErNvg-lVbGgj4kMCcVb1ClLc'
};

const geocoder = nodeGeocoder(options);

const jsonToFireStore = async() => {
	
	
	var foodArea = "/Users/chohyeonjun/IdeaProjects/intoJsonFromFirestore/cvsFile/여행길잡이_data - 맛집.csv";
	var lodgeArea = "/Users/chohyeonjun/IdeaProjects/intoJsonFromFirestore/cvsFile/여행길잡이_data - 숙소.csv";
	var placeArea = "/Users/chohyeonjun/IdeaProjects/intoJsonFromFirestore/cvsFile/여행길잡이_data - 관광지.csv";

	var filePath = [foodArea, lodgeArea, placeArea];
	var path = ["foodArea", "lodgeArea", "placeArea"];
	
	filePath.forEach((id, idx) => convCsv2Json(id, path[idx]));

}

function convCsv2Json(id, pathId){
	var csv = require("csvtojson");
	var fs = require("fs");
	const data = new Object;
	// Convert a csv file with csvtojson
	csv()
	.fromFile(id)
	.then( async function(jsonArrayObj){ //when parse finished, result will be emitted here.
		var array = new Array;
		for(var idx = 0; idx < jsonArrayObj.length; idx++){
			jsonArrayObj[idx].idx = idx.toString();
		}
		data[pathId] = jsonArrayObj;
		// area 넣기
		fs.writeFile("./area/"+pathId + ".json", JSON.stringify(data), 'utf8', function(error){
			console.log('주소 관련 데이터 넣는중...');
		});
		for await(const param of jsonArrayObj){
			var addressObj = new Object;
			var idx = param.idx;
			var address = param.address;
			const regionLatLongResult = await geocoder.geocode(address);
			const lat = regionLatLongResult[0].latitude.toString();
			const long =  regionLatLongResult[0].longitude.toString();

			addressObj["idx"] = idx.toString();
			addressObj["address"] = address;
			addressObj["lat"] = lat;
			addressObj["long"] = long;
			array.push(addressObj);

		}
		var jsonData = new Object;
		jsonData["geocode_"+pathId] = array;
		fs.writeFile("./area/geocode_"+pathId+".json", JSON.stringify(jsonData), 'utf8', function(error){
			console.log('GeoCode관련 데이터 넣는중...');
		});
	})
	
	
}



jsonToFireStore();