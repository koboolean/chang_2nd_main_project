const  firestoreService = require('firestore-export-import');
const firebaseConfig = require('./config.js');
const serviceAccount = require('./serviceAccount.json');

const jsonToFireStore = async() => {
	var fs = require("fs");
    var fss = fs.readdirSync("./area");

    for(var i = 0; i < fss.length; i++){
        try{
            console.log('Initialzing.Firebase');
            await firestoreService.initializeFirebaseApp(serviceAccount, firebaseConfig.databaseURL);
            console.log('TT');
    
            await firestoreService.restore('./area/'+fss[i]);
            console.log('Success');
        }
        catch(e){
            console.log(e);
        }
    
    }
}   



jsonToFireStore();