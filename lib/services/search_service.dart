import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchService extends ChangeNotifier {
  final foodCollection = FirebaseFirestore.instance.collection('foodArea');
  final lodgeCollection = FirebaseFirestore.instance.collection('lodgeArea');
  final placeCollection = FirebaseFirestore.instance.collection('placeArea');

  Future<QuerySnapshot> foodRead() async{
    return foodCollection.get();
  }

  Future<QuerySnapshot> lodgeRead() async{
    return lodgeCollection.get();
  }

  Future<QuerySnapshot> placeRead() async{
    return placeCollection.get();
  }


}

