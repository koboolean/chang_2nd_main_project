import 'dart:developer';

import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/services/search_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteFoodService extends ChangeNotifier {
  final FavoriteFoodCollection =
      FirebaseFirestore.instance.collection('foodNameUser');

  Future<QuerySnapshot> read(String uid) async {
    throw FavoriteFoodCollection.where('uid', isEqualTo: uid)
        .get(); // return 값 미구현 에러
  }

  List<Map<String, dynamic>> postFoodList = [];

  void toggleFavoriteFood(String idx) async {
    // name을 nameid 로 가져오기
    // user id 가져오기
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;

    FirebaseFirestore.instance
        .collection('foodNameUser')
        .doc("${idx}_$uid")
        .get()
        .then((doc) async {
      if (doc.exists) {
        await FirebaseFirestore.instance
            .collection("foodNameUser")
            .doc("${idx}_$uid")
            .delete();
        print("deleted");
      } else {
        await FirebaseFirestore.instance
            .collection("foodNameUser")
            .doc("${idx}_$uid")
            .set({
          "idx": idx,
          "userId": uid,
          "selectedCheckBox": false,
        });
        print("created");
      }
    });

    final tagID = uid;
    final post_idx = await FirebaseFirestore.instance
        .collection("foodNameUser")
        .where('userId', isEqualTo: tagID)
        .get();
    final postIdList = post_idx.docs.map((doc) => doc.data()["idx"]).toList();

    final postSnapshot = await FirebaseFirestore.instance
        .collection("foodArea")
        .where("idx", whereIn: postIdList)
        .get();

    postFoodList = postSnapshot.docs.map((doc) => doc.data()).toList();
  }
}

class FavoriteLodgeService extends ChangeNotifier {
  final FavoriteLodgeCollection =
      FirebaseFirestore.instance.collection('lodgeNameUser');

  Future<QuerySnapshot> read(String uid) async {
    throw FavoriteLodgeCollection.where('uid', isEqualTo: uid)
        .get(); // return 값 미구현 에러
  }

  List<Map<String, dynamic>> postLodgeList = [];

  void toggleFavoriteLodge(String idx) async {
    // name을 nameid 로 가져오기
    // user id 가져오기
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;

    FirebaseFirestore.instance
        .collection('lodgeNameUser')
        .doc("${idx}_$uid")
        .get()
        .then((doc) async {
      if (doc.exists) {
        await FirebaseFirestore.instance
            .collection("lodgeNameUser")
            .doc("${idx}_$uid")
            .delete();
        print("deleted");
      } else {
        await FirebaseFirestore.instance
            .collection("lodgeNameUser")
            .doc("${idx}_$uid")
            .set({
          "idx": idx,
          "userId": uid,
          "selectedCheckBox": false,
        });
        print("created");
      }
    });

    final tagID = uid;
    final post_idx = await FirebaseFirestore.instance
        .collection("lodgeNameUser")
        .where('userId', isEqualTo: tagID)
        .get();
    final postIdList = post_idx.docs.map((doc) => doc.data()["idx"]).toList();

    final postSnapshot = await FirebaseFirestore.instance
        .collection("lodgeArea")
        .where("idx", whereIn: postIdList)
        .get();

    postLodgeList = postSnapshot.docs.map((doc) => doc.data()).toList();
  }
}

class FavoritePlaceService extends ChangeNotifier {
  final FavoritePlaceCollection =
      FirebaseFirestore.instance.collection('placeNameUser');

  Future<QuerySnapshot> read(String uid) async {
    throw FavoritePlaceCollection.where('uid', isEqualTo: uid)
        .get(); // return 값 미구현 에러
  }

  List<Map<String, dynamic>> postPlaceList = [];

  void toggleFavoritePlace(String idx) async {
    // name을 nameid 로 가져오기
    // user id 가져오기
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;

    FirebaseFirestore.instance
        .collection('placeNameUser')
        .doc("${idx}_$uid")
        .get()
        .then((doc) async {
      if (doc.exists) {
        await FirebaseFirestore.instance
            .collection("placeNameUser")
            .doc("${idx}_$uid")
            .delete();
        print("deleted");
      } else {
        await FirebaseFirestore.instance
            .collection("placeNameUser")
            .doc("${idx}_$uid")
            .set({
          "idx": idx,
          "userId": uid,
          "selectedCheckBox": false,
        });
        print("created");
      }
    });

    final tagID = uid;
    final post_idx = await FirebaseFirestore.instance
        .collection("placeNameUser")
        .where('userId', isEqualTo: tagID)
        .get();
    final postIdList = post_idx.docs.map((doc) => doc.data()["idx"]).toList();

    final postSnapshot = await FirebaseFirestore.instance
        .collection("placeArea")
        .where("idx", whereIn: postIdList)
        .get();

    postPlaceList = postSnapshot.docs.map((doc) => doc.data()).toList();
  }
}

class FavoriteListService extends ChangeNotifier{
  final foodCollection = FirebaseFirestore.instance.collection('foodNameUser');
  final lodgeCollection = FirebaseFirestore.instance.collection('lodgeNameUser');
  final placeCollection = FirebaseFirestore.instance.collection('placeNameUser');

  List<String> favFoodList = [];
  List<String> favLodgeList = [];
  List<String> favPlaceList = [];

  Future<int> getFavorite(String uid) async{
   var foodList = await getFood(uid);
    var lodgeList = await getLodge(uid);
    var placeList = await getPlace(uid);

    var count = foodList.docs.length + lodgeList.docs.length + placeList.docs.length;

    return count;
  }

  Future<QuerySnapshot> getFood(String uid) async{
    return await foodCollection.where("userId",isEqualTo: uid).get();
  }

  Future<QuerySnapshot> getLodge(String uid) async{
    return await lodgeCollection.where("userId",isEqualTo: uid).get();
  }

  Future<QuerySnapshot> getPlace(String uid) async{
    return await placeCollection.where("userId",isEqualTo: uid).get();
  }

  Future<List<Map<String, dynamic>>> getFavoriteFood(String uid) async{
    final food = await await foodCollection.where("userId",isEqualTo: uid).get();
    final postIdList = food.docs.map((doc) => doc.data()["idx"]).toList();

    List<List<dynamic>> subList = [];
    for (var i = 0; i < postIdList.length; i += 10) {
      subList.add(
          postIdList.sublist(i, i + 10 > postIdList.length ? postIdList.length : i + 10));
    }

    final List<Map<String, dynamic>> foodList = [];

    for(var i = 0; i < subList.length; i++){
      var list = await SearchService().foodCollection.where('idx', whereIn: subList[i]).get();
      var data = list.docs.map((doc) => doc.data()).toList();
      foodList.addAll(data);
    }

    return foodList;

  }

  Future<List<Map<String, dynamic>>> getFavoriteLodge(String uid) async{
    final food = await await lodgeCollection.where("userId",isEqualTo: uid).get();
    final postIdList = food.docs.map((doc) => doc.data()["idx"]).toList();

    List<List<dynamic>> subList = [];
    for (var i = 0; i < postIdList.length; i += 10) {
      subList.add(
          postIdList.sublist(i, i + 10 > postIdList.length ? postIdList.length : i + 10));
    }

    final List<Map<String, dynamic>> foodList = [];

    for(var i = 0; i < subList.length; i++){
      var list = await SearchService().lodgeCollection.where('idx', whereIn: subList[i]).get();
      var data = list.docs.map((doc) => doc.data()).toList();
      foodList.addAll(data);
    }

    return foodList;

  }

  Future<List<Map<String, dynamic>>> getFavoritePlace(String uid) async{
    final food = await await placeCollection.where("userId",isEqualTo: uid).get();
    final postIdList = food.docs.map((doc) => doc.data()["idx"]).toList();

    List<List<dynamic>> subList = [];
    for (var i = 0; i < postIdList.length; i += 10) {
      subList.add(
          postIdList.sublist(i, i + 10 > postIdList.length ? postIdList.length : i + 10));
    }

    final List<Map<String, dynamic>> foodList = [];

    for(var i = 0; i < subList.length; i++){
      var list = await SearchService().placeCollection.where('idx', whereIn: subList[i]).get();
      var data = list.docs.map((doc) => doc.data()).toList();
      foodList.addAll(data);
    }

    return foodList;

  }
}