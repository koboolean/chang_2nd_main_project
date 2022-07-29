import 'package:chang_2nd_main_project/screens/favorite_list.dart';
import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:chang_2nd_main_project/screens/notification.dart';
import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/screens/place_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chang_2nd_main_project/services/travel_service.dart';

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
    return Consumer<TravelService>(
      builder: (context, travelService, child) {
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
                          indicatorWeight: 3,
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
                  FoodList(),
                  LodgeList(),
                  PlacetogoList(),
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
class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    // 전체 Column 구조
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('foodArea').snapshots(),
        builder: (context, snapshot) {
          final documents = snapshot.data?.docs ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error loading data: ${snapshot.error!}');
          }
          return Column(
            children: [
              SizedBox(height: 19),
              // 키워드에 따른 음식점 리스트
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    //Firestore 변수 설정
                    final doc = documents[index];
                    String name = doc.get('name');
                    String url = doc.get('url');
                    String address = doc.get('address');
                    String classification = doc.get('classification');
                    bool isFavorite = doc.get('isFavorite');
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Stack 구조
                        Stack(
                          children: [
                            //사진 박스
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, right: 18.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.grey,

                                  //사진 삽입
                                  image: DecorationImage(
                                    image: NetworkImage(url),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: double.maxFinite,
                                height: 142, //실제 높이 142-16 = 126
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
                                      "#$classification",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x9e000000),
                                            offset: Offset(0, 2),
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 9.0, left: 24.0, bottom: 2.0),
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, left: 24.0, bottom: 14.0),
                          child: Text(
                            address,
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
        });
  }
}

// 맛집 Body
class LodgeList extends StatefulWidget {
  const LodgeList({Key? key}) : super(key: key);

  @override
  State<LodgeList> createState() => _LodgeListState();
}

class _LodgeListState extends State<LodgeList> {
  @override
  Widget build(BuildContext context) {
    // 전체 Column 구조
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('lodgeArea').snapshots(),
        builder: (context, snapshot) {
          final documents = snapshot.data?.docs ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error loading data: ${snapshot.error!}');
          }
          return Column(
            children: [
              SizedBox(height: 19),
              // 키워드에 따른 음식점 리스트
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    //Firestore 변수 설정
                    final doc = documents[index];
                    String name = doc.get('name');
                    String url = doc.get('url');
                    String address = doc.get('address');
                    String pricetype3 = doc.get('priceType3');
                    bool isFavorite = doc.get('isFavorite');
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Stack 구조
                        Stack(
                          children: [
                            //사진 박스
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, right: 18.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.grey,

                                  //사진 삽입
                                  image: DecorationImage(
                                    image: NetworkImage(url),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: double.maxFinite,
                                height: 142, //실제 높이 142-16 = 126
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
                                      "#$pricetype3",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x9e000000),
                                            offset: Offset(0, 2),
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 9.0, left: 24.0, bottom: 2.0),
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, left: 24.0, bottom: 14.0),
                          child: Text(
                            address,
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
        });
  }
}

// 맛집 Body
class PlacetogoList extends StatefulWidget {
  const PlacetogoList({Key? key}) : super(key: key);

  @override
  State<PlacetogoList> createState() => _PlacetogoListState();
}

class _PlacetogoListState extends State<PlacetogoList> {
  @override
  Widget build(BuildContext context) {
    // 전체 Column 구조
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('placeArea').snapshots(),
        builder: (context, snapshot) {
          final documents = snapshot.data?.docs ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error loading data: ${snapshot.error!}');
          }
          return Column(
            children: [
              SizedBox(height: 19),
              // 키워드에 따른 음식점 리스트
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    //Firestore 변수 설정
                    final doc = documents[index];
                    String name = doc.get('name');
                    String url = doc.get('url');
                    String address = doc.get('address');
                    String classification = doc.get('classification');
                    bool isFavorite = doc.get('isFavorite');
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Stack 구조
                        Stack(
                          children: [
                            //사진 박스
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, right: 18.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.grey,

                                  //사진 삽입
                                  image: DecorationImage(
                                    image: NetworkImage(url),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: double.maxFinite,
                                height: 142, //실제 높이 142-16 = 126
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
                                      "#$classification",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x9e000000),
                                            offset: Offset(0, 2),
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 9.0, left: 24.0, bottom: 2.0),
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, left: 24.0, bottom: 14.0),
                          child: Text(
                            address,
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
        });
  }
}
