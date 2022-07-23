import 'package:chang_2nd_main_project/models/food.dart';
import 'package:flutter/material.dart';

class TripService extends ChangeNotifier {
  List<Food> foodList = [
    Food(
      "맛집이름1",
      "맛집주소1",
    )
  ];
}