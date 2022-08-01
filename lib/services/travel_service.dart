import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TravelService extends ChangeNotifier {
  final travelFoodCollection =
      FirebaseFirestore.instance.collection('foodArea');
  final travelLodgeCollection =
      FirebaseFirestore.instance.collection('foodArea');
  final travelCollection = FirebaseFirestore.instance.collection('foodArea');

  Future<QuerySnapshot> read(String name) async {
    // 내 bucketList 가져오기
    return travelCollection.get();
  }

  void update(String docId, bool isFavorite) async {
    // bucket isDone 업데이트
    await travelCollection.doc(docId).update({'isFavorite': isFavorite});
    notifyListeners(); // 화면 갱신
  }
}
