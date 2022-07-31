import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteFoodService extends ChangeNotifier {
  final FavoriteFoodCollection =
      FirebaseFirestore.instance.collection('foodNameUser');

  Future<QuerySnapshot> read(String uid) async {
    // 내 bucketList 가져오기
    throw UnimplementedError(); // return 값 미구현 에러
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
            .set({"idx": idx, "userId": uid});
        print("created");
      }
    });
  }
}
