import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class FavoriteButton extends ChangeNotifier {
  List favoriteFoodList = [];
  List favoriteLodgeList = [];
  List favoritePlaceList = [];
  bool favoriteFoodBool = false;
  bool favoriteLodgeBool = false;
  bool favoritePlaceBool = false;

  void favoriteFoodButton(String idx) {
    if (favoriteFoodList.contains(idx)) {
      favoriteFoodList.remove(idx);
      favoriteFoodBool = !favoriteFoodBool;

      notifyListeners();
    } else {
      favoriteFoodList.add(idx);

      notifyListeners();
    }
  }

  void favoriteLodgeButton(String idx) {
    if (favoriteLodgeList.contains(idx)) {
      favoriteLodgeList.remove(idx);
      favoriteLodgeBool = !favoriteLodgeBool;
      notifyListeners();
    } else {
      favoriteLodgeList.add(idx);

      notifyListeners();
    }
  }

  void favoritePlaceButton(String idx) {
    if (favoritePlaceList.contains(idx)) {
      favoritePlaceList.remove(idx);
      favoritePlaceBool = !favoritePlaceBool;
      print('Place 테스트 off');
      notifyListeners();
    } else {
      favoritePlaceList.add(idx);
      print('Place 테스트 on');

      notifyListeners();
    }
  }
}
