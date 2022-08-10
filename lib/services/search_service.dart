import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchService extends ChangeNotifier {
  final foodCollection = FirebaseFirestore.instance.collection('foodArea');
  final lodgeCollection = FirebaseFirestore.instance.collection('lodgeArea');
  final placeCollection = FirebaseFirestore.instance.collection('placeArea');

  Future<QuerySnapshot> foodRead(String type) async{
    return foodCollection.get();
  }

  Future<QuerySnapshot> lodgeRead(String type) async{
    return lodgeCollection.get();
  }

  Future<QuerySnapshot> placeRead(String type) async{
    return placeCollection.get();
  }


}

