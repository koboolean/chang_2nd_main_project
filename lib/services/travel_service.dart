import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TravelService extends ChangeNotifier {
  bool isReadMore = true;
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

  void readMoreButton() {
    isReadMore = !isReadMore;
    notifyListeners();
  }

  Future<QuerySnapshot> businessHourData(String foodidx) async {
    return await travelCollection.where('idx', isEqualTo: foodidx).get();
  }

//place_list 파일 stream bulider 필터링
  Stream<QuerySnapshot> filtering(
      String collectionName, String sendSelectedValue, String sendClass) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('area',
            isEqualTo: sendSelectedValue == "전체" ? null : sendSelectedValue)
        .where('classification',
            isEqualTo: sendClass == "전체" ? null : sendClass)
        .snapshots();
  }
}
