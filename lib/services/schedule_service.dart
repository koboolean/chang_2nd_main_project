import 'package:chang_2nd_main_project/main.dart';
import 'package:chang_2nd_main_project/screens/place_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleService extends ChangeNotifier {
  List<String> itemsList = []; //화면에 출력된 항목 담을 변수
  //List<DisplaySelectList> checkedList = []; //체크된 항목 담을 변수

  void toggleCheckBox(String idx) {
    if (itemsList.contains(idx)) {
      itemsList.remove(idx);
    } else {
      itemsList.add(idx);
    }
    //itemList.checkBox = !itemList.checkBox;

    // print(checkedList);
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
  bool selectRouteEnable;
  String idx;
  //bool keyWordCheck;
  DisplaySelectList(
      {Key? key,
      required this.name,
      required this.classification,
      required this.address,
      required this.imageUrl,
      required this.selectRouteEnable,
      // required keyWordCheck
      required this.idx});
}
