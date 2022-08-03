import 'package:chang_2nd_main_project/main.dart';
import 'package:chang_2nd_main_project/screens/place_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleService extends ChangeNotifier {
  List<String> foodAndPlaceItemsList = []; //맛집 탭 화면에 클릭한 항목 담을 변수
  //List<String> placeItemsList = []; //관광지 탭 화면에 클릭한 항목 담을 변수

  //List<int> countingSelect = [1,2,3,]
  //List<DisplaySelectList> checkedList = []; //체크된 항목 담을 변수

  void TabToggle(String idx) {
    if (foodAndPlaceItemsList.contains(idx)) {
      foodAndPlaceItemsList.remove(idx);
    } else {
      foodAndPlaceItemsList.add(idx);
    }
    notifyListeners();
  }

  void toggleCheckBox(String idx) {
    if (foodAndPlaceItemsList.contains(idx)) {
      foodAndPlaceItemsList.remove(idx);
    } else {
      foodAndPlaceItemsList.add(idx);
    }
    notifyListeners();
  }

  // void checkedBox(String itemListIdx) {
  //   if (checkedList.contains(itemListIdx)) {
  //     checkedList.remove(itemListIdx);
  //   } else {
  //     itemList.selectRouteEnable = !itemList.selectRouteEnable;
  //     checkedList.add(itemList);
  //   }
  //   notifyListeners();
  // }
}

class DisplaySelectList {
  String name;
  String classification;
  String address;
  String imageUrl;
  bool selectRouteEnable = false;
  String idx;
  String lat;
  String long;
  //bool keyWordCheck;
  DisplaySelectList(
      {Key? key,
      required this.name,
      required this.classification,
      required this.address,
      required this.imageUrl,
      //required this.selectRouteEnable,
      // required keyWordCheck
      required this.idx,
      required this.lat,
      required this.long});
}
