import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Food {
  String name; //이름
  String address; //주소
  String url;
  bool isFavorite;
  Food(
    this.name,
    this.address,
    this.url,
    this.isFavorite,
  ); //생성자
}

class TripService extends ChangeNotifier {
  final tripCollection = FirebaseFirestore.instance.collection('foodArea');

  Future<QuerySnapshot> read(String uid) async {
    // Tripcollection 가져오기
    return tripCollection.where('uid', isEqualTo: uid).get();
  }

  List<Food> foodList = [
    Food(
        '맛집이름1',
        '맛집주소1',
        'https://middleclass.sg/wp-content/uploads/2022/04/Donuts-at-Cafe-Knotted-Peaches.jpg',
        false),
    Food(
        '맛집이름2',
        '맛집주소2',
        'https://middleclass.sg/wp-content/uploads/2022/04/Donuts-at-Cafe-Knotted-Peaches.jpg',
        false),
    Food(
        '맛집이름3',
        '맛집주소3',
        'https://middleclass.sg/wp-content/uploads/2022/04/Donuts-at-Cafe-Knotted-Peaches.jpg',
        false),
    Food(
        '맛집이름4',
        '맛집주소4',
        'https://middleclass.sg/wp-content/uploads/2022/04/Donuts-at-Cafe-Knotted-Peaches.jpg',
        false),
  ];

  void updateFood(Food food, int index) {
    foodList[index] = food;
    notifyListeners();
  }
}
