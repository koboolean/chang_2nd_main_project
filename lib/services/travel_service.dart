import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TravelService extends ChangeNotifier {
  final travelCollection = FirebaseFirestore.instance.collection('foodArea');

  Future<QuerySnapshot> read(String name) async {
    // 내 bucketList 가져오기
    return travelCollection.get();
  }
}
