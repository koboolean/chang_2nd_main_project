import 'package:chang_2nd_main_project/screens/place_info.dart';
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
            .set({"idx": idx, "userId": uid, "selectRouteEnable": false});
        print("created");
      }
    });
  }

  void favoriteFoodList(String idx) async {
    // name을 nameid 로 가져오기
    // user id 가져오기
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;

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

    final postList = postSnapshot.docs.map((doc) => doc.data()).toList();
  }
}

class FavoriteLodgeService extends ChangeNotifier {
  final FavoriteLodgeCollection =
      FirebaseFirestore.instance.collection('lodgeNameUser');

  Future<QuerySnapshot> read(String uid) async {
    throw UnimplementedError(); // return 값 미구현 에러
  }

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
            .set({"idx": idx, "userId": uid});
        print("created");
      }
    });
  }
}

class FavoritePlaceService extends ChangeNotifier {
  final FavoritePlaceCollection =
      FirebaseFirestore.instance.collection('placeNameUser');

  Future<QuerySnapshot> read(String uid) async {
    throw UnimplementedError(); // return 값 미구현 에러
  }

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
            .set({"idx": idx, "userId": uid});
        print("created");
      }
    });
  }
}
