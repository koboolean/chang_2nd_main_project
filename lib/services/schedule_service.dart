import 'package:chang_2nd_main_project/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleService extends ChangeNotifier {
  List<DisplaySelectList> foodTabList = [
    //더미 데이터
    DisplaySelectList(
      name: '소랑드르',
      category: '한식',
      address: '제주 제주시 조천읍 비자림로 666',
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210827_73%2F1630039716072SP1Ci_JPEG%2FLdu9TNgwhtmGb4CUVPawnkij.jpg',
      checkBox: false,
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '소길역',
      category: '일식',
      address: '제주 제주시 애월읍 소길2길 53',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20211106_252%2F1636209401119Wgzex_JPEG%2FPO2oa8UJIK-BDsu4adnRn2SE.jpg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '금능상회 해물라면',
      category: '카페',
      address: '제주 제주시 한림읍 금능5길 21 2층',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20191227_155%2F15774232069512qVaE_JPEG%2FjRVXCRjxVJwbo074zGWXmFgv.jpeg.jpg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '체면',
      category: '한식',
      address: '제주 서귀포시 대정읍 단산로 95 1층',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20180403_92%2F1522749151779n14zX_JPEG%2FRhV8vslzHJbp_ZFkuV9nG3ht.jpg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '다소니',
      category: '한식/차',
      address: '제주 제주시 오남로6길 24',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210501_138%2F1619868637418VpnCm_JPEG%2FQx4sSEjJjs8xufqYsj8K5VeP.jpeg.jpg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '미친부엌',
      category: '일식',
      address: '제주 제주시 탑동로 15 1,2층',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20191217_98%2F1576518987370lGKMd_JPEG%2FD7Dpqa0MBbVYYcEeupQcKXJU.jpg',
      keyWordCheck: false,
    ),
  ];
  List<DisplaySelectList> hotelTabList = [
    //더미 데이터
    DisplaySelectList(
      name: '제주공항게스트하우스 웨이브사운드',
      category: '숙소',
      address: '제주 제주시 관덕로8길 24',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210908_108%2F1631034411484UFvVl_JPEG%2FKakaoTalk_20210908_015016746_02.jpg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '제주도게스트하우스파티 한담누리',
      category: '숙소',
      address: '제주 제주시 애월읍 일주서로 6158',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20160207_82%2F1454810790665mlc7N_JPEG%2F176157513649968_3.jpeg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '백패커스홈',
      category: '숙소',
      address: '제주 서귀포시 중정로 24-7 1층',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20211210_186%2F16391376563571tGXK_JPEG%2F%25BA%25B8%25C1%25A4%25BA%25BB_%25BA%25CE%25B4%25EB%25BD%25C3%25BC%25B3_5%25C3%25FE_%25B7%25E7%25C7%25C1%25C5%25BE_%25C0%25FA%25B3%25E1_%25281%2529.jpg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '미도호스텔',
      category: '숙소',
      address: '제주 서귀포시 동문동로 13-1 미도호스텔 게스트하우스',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210908_108%2F1631034411484UFvVl_JPEG%2FKakaoTalk_20210908_015016746_02.jpg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '성산 스테이션',
      category: '숙소',
      address: '제주 서귀포시 성산읍 성산중앙로 43',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20201203_210%2F16070040064143B9YW_JPEG%2FJP-w3WqXsGyv2xKBAOZr6kpO.jpg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '1미리 게스트하우스',
      category: '숙소',
      address: '제주 제주시 한림읍 협재6길 22-4',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20211213_293%2F1639386864665SzVOq_JPEG%2FKakaoTalk_20211213_175655854_05.jpg',
      keyWordCheck: false,
    ),
  ];
  List<DisplaySelectList> touristTabList = [
    //더미 데이터
    DisplaySelectList(
      name: '협재해수욕장',
      category: '바다',
      address: '제주 제주시 한림읍 협재리 2497-1',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200229_126%2F1582909660415raR5g_JPEG%2Fzbz476xQvvB4womCCEGDyaRi.jpg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '한림공원',
      category: '공원',
      address: '주소  제주특별자치도 제주시 한림로 300',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220523_209%2F1653271074242H1Dy1_JPEG%2F%25BA%25CE%25B0%25D5%25BA%25F4%25B7%25B9%25BE%25C6_%252812%2529.jpg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '금능해수욕장',
      category: '바다',
      address: '제주 제주시 한림읍 금능리',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200229_68%2F1582909264425bhjsN_JPEG%2FPNMaDI7V1kIXW656-xRlkbBP.jpg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '제주맥주',
      category: '관람, 체험',
      address: '제주 제주시 한림읍 금능농공길 62-11',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210305_87%2F1614916166023FL19X_PNG%2FZEMZ650VIiYyexeTuiioIQYO.png',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '성산일출봉',
      category: '오름',
      address: '제주 서귀포시 성산읍 성산리 1',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200525_49%2F1590412262227GMkHw_JPEG%2FC4zldSa-iFht-lmY9n-2LZLI.jpeg.jpg',
      keyWordCheck: false,
    ),
    DisplaySelectList(
      name: '비자림',
      category: '휴양림',
      address: '제주 제주시 구좌읍 비자숲길 55',
      checkBox: false,
      imageUrl:
          'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150831_115%2F1441015829482aatdh_JPEG%2F116963507552852_0.jpg',
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
  String imageUrl;
  bool checkBox;
  bool keyWordCheck;
  DisplaySelectList(
      {Key? key,
      required this.name,
      required this.category,
      required this.address,
      required this.imageUrl,
      required this.checkBox,
      required this.keyWordCheck});
}
