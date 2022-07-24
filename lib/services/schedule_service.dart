import 'package:chang_2nd_main_project/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleService extends ChangeNotifier {
  List<DisplaySelectList> foodTabList = [
    //더미 데이터
    DisplaySelectList(
      name: '장소',
      category: '카페',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '카페',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '카페',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '카페',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '카페',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '카페',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
  ];
  List<DisplaySelectList> hotelTabList = [
    //더미 데이터
    DisplaySelectList(
      name: '장소',
      category: '숙소',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '숙소',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '숙소',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '숙소',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '숙소',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '숙소',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
  ];
  List<DisplaySelectList> touristTabList = [
    //더미 데이터
    DisplaySelectList(
      name: '장소',
      category: '관광지',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '관광지',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '관광지',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '관광지',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '관광지',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '장소',
      category: '관광지',
      address: '주소',
      checkBox: false,
      keyWordCheck: false,
    ),
  ];
  List<DisplaySelectList> checkedList = []; //체크된 항목 담을 변수

  void toggleCheckBox(DisplaySelectList food) {
    if (checkedList.contains(food)) {
      checkedList.remove(food);
    } else {
      checkedList.add(food);
    }
    //food.checkBox = !food.checkBox;

    // print(checkedList);
    notifyListeners();
  }

  void checkedBox(food) {
    if (checkedList.contains(food)) {
      checkedList.remove(food);
    } else {
      food.checkBox = !food.checkBox;
      checkedList.add(food);
    }
    notifyListeners();
  }

  // List selectedCheckBox() {
  //   List test = [];
  //   List test2 = [];
  //   test.add(foodTabList);
  //   test.add(hotelTabList);
  //   test.add(touristTabList);
  //   print(test);
  //   return test;
  //   // print(test);
  // }

  // Widget listViewBuild(List Tab) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //       leadingWidth: 0,
  //       title: Row(
  //         children: [
  //           TextButton(
  //             onPressed: () {},
  //             style: TextButton.styleFrom(
  //               primary: Colors.black,
  //               backgroundColor: Colors.grey,
  //               minimumSize: Size(63, 32),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(100),
  //               ),
  //             ),
  //             child: Text('전체'),
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           TextButton(
  //             onPressed: () {},
  //             style: TextButton.styleFrom(
  //               primary: Colors.black,
  //               backgroundColor: Colors.grey,
  //               minimumSize: Size(63, 32),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(100),
  //               ),
  //             ),
  //             child: Text('1인분 주문가능'),
  //           ),
  //         ],
  //       ),
  //     ),
  //     body: ListView.builder(
  //       itemCount: Tab.length,
  //       itemBuilder: (context, index) {
  //         var schedual = Tab[index];
  //         return ListTile(
  //           leading: FlutterLogo(size: 56.0),
  //           title: Row(
  //             children: [
  //               Text(schedual.name),
  //               SizedBox(
  //                 width: 6,
  //               ),
  //               Text(schedual.catagory),
  //             ],
  //           ),
  //           subtitle: Row(
  //             children: [
  //               Icon(Icons.place_outlined),
  //               SizedBox(
  //                 width: 3.5,
  //               ),
  //               Text(schedual.address),
  //             ],
  //           ),
  //           trailing: schedual.checkBox
  //               ? Icon(Icons.check_circle_outline, color: Colors.amber)
  //               : Icon(
  //                   Icons.check_circle_outline,
  //                   color: Colors.grey[350],
  //                 ),
  //           onTap: () {
  //             toggleCheckBox(schedual, index);
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
}

class DisplaySelectList {
  String name;
  String category;
  String address;
  bool checkBox;
  bool keyWordCheck;
  DisplaySelectList(
      {Key? key,
      required this.name,
      required this.category,
      required this.address,
      required this.checkBox,
      required this.keyWordCheck});
}
