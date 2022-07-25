import 'package:chang_2nd_main_project/screens/favorite_list.dart';
import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:chang_2nd_main_project/screens/notification.dart';
import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/screens/place_list.dart';

import 'package:chang_2nd_main_project/services/trip_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

/// 홈페이지
class PlaceList extends StatefulWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  TextEditingController jobController = TextEditingController();
  final _valueList = [
    '전체',
    '한림/협재',
    '애월',
    '제주시',
    '한라산 지구',
    '서귀포/중문',
    '성산',
    '함덕/구좌',
    '우도',
  ];
  var _selectedValue = "전체";

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return Consumer(
      builder: (context, bucketService, child) {
        return Scaffold(
          body: DefaultTabController(
            length: 3,
            child: Scaffold(
              //appbar
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                centerTitle: false,
                iconTheme: IconThemeData(color: Colors.black),
                title: const Text(
                  "제주도",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  )
                ],
                bottom: PreferredSize(
                  preferredSize: const Size(double.infinity, 100),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      right: 18.0,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: DropdownButton(
                              value: _selectedValue,
                              items: _valueList.map(
                                (value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                        const TabBar(
                          indicatorColor: Colors.amber,
                          labelColor: Colors.amber,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(
                                child: Text(
                              "맛집",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )),
                            Tab(
                                child: Text(
                              "숙소",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )),
                            Tab(
                                child: Text(
                              "관광지",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: const TabBarView(
                children: [
                  Dining(),
                  Dining(),
                  Dining(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// 맛집 Body
class Dining extends StatefulWidget {
  const Dining({Key? key}) : super(key: key);

  @override
  State<Dining> createState() => _DiningState();
}

class _DiningState extends State<Dining> {
  @override
  Widget build(BuildContext context) {
    // 전체 Column 구조
    return Column(
      children: [
        // 키워드에 따른 음식점 리스트
        Expanded(
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Stack 구조
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Stack(
                      children: [
                        //사진 박스
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 18.0, right: 18.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.grey,

                              //사진 삽입
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/login_background.jpeg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            width: double.maxFinite,
                            height: 200,
                          ),
                        ),
                        // 하트 아이콘
                        Positioned(
                          top: 10,
                          right: 30,
                          child: GestureDetector(
                            onTap: () {
                              // setState(() => isPressed = !isPressed);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.grey[700]!.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child:
                                  // (isPressed) ? Icon(
                                  // Icons.favorite_border,
                                  // color: Colors.white,
                                  // size: 24,
                                  // ),
                                  // :
                                  // Icon(
                                  // Icons.favorite,
                                  // color: Colors.red,
                                  // size: 24,
                                  // ),
                                  Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        // 해시태그 키워드
                        Positioned(
                          bottom: 10,
                          left: 28,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "#1인 맛집",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "#12,000원",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2.0, left: 24.0, bottom: 2.0),
                    child: Text(
                      "맛집 이름",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2.0, left: 24.0, bottom: 2.0),
                    child: Text(
                      "음식점 장소",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
