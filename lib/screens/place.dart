import 'dart:math';

import 'package:chang_2nd_main_project/screens/favorite_list.dart';
import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:chang_2nd_main_project/screens/notification.dart';
import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/screens/place_list.dart';
import 'package:chang_2nd_main_project/services/travel_service.dart';
import 'package:chang_2nd_main_project/main.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

/// 홈페이지
class Place extends StatefulWidget {
  const Place({Key? key}) : super(key: key);

  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<TravelService>(
      builder: (context, travelService, child) {
        return Scaffold(
          //AppBar
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0, right: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationList()),
                    );
                  },
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(190),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///AppBar Title
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      "어디로 여행가시나요?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  /// Textfield
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 4.0, bottom: 4.0),
                    child: TextField(
                      //controller 삽입 필요
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(243, 243, 243, 1),
                        hintText: "ex.김녕 바당길(바닷길)",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),

                        /// 돋보기 아이콘
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // 돋보기 아이콘 클릭
                          },
                        ),
                      ),
                      onSubmitted: (v) {
                        // 엔터를 누르는 경우
                      },
                    ),
                  ),

                  /// 요즘 인기있는 여행지
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 16,
                      bottom: 8,
                    ),
                    child: Text(
                      "요즘 인기있는 여행지",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  /// 여행지 아이콘
                  Padding(
                    padding: const EdgeInsets.only(left: 18, top: 0, bottom: 8),
                    child: SizedBox(
                      height: 32,
                      child: TravelPlace(),
                    ),
                  ),
                  Container(
                    height: 7,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(243, 243, 243, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //body
          body: SingleChildScrollView(
            child: Column(
              children: [
                RecommendFoodList(),
              ],
            ),
          ),
        );
      },
    );
  }
}

//여행지 아이콘 함수

class TravelPlace extends StatefulWidget {
  TravelPlace({Key? key}) : super(key: key);

  @override
  State<TravelPlace> createState() => _TravelPlaceState();
}

class _TravelPlaceState extends State<TravelPlace> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 1,
      itemBuilder: ((context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceList()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Container(
              height: 32,
              width: 66,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey[500]!,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "제주도",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

//음식점 추천 리스트

class RecommendFoodList extends StatefulWidget {
  RecommendFoodList({Key? key}) : super(key: key);

  @override
  State<RecommendFoodList> createState() => _RecommendFoodListState();
}

//음식점 제안 코멘트
final foodComment = <String>{
  '오늘 점심은 여기서! 어때요?',
  '혼밥도 어렵지 않아요!',
  '요즘 혼밥 핫플은 여기에요',
  '1인분 주문도 가능한 식당',
  '오늘 저녁은 혼자서 분위기 있게',
};

//Random 숫자 반환
int foodrandomIndex = Random().nextInt(4);

class _RecommendFoodListState extends State<RecommendFoodList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('foodArea').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error loading data: ${snapshot.error!}');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //리스트 설명 텍스트
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 18.0, bottom: 8.0),
              child: Text(
                //foodComment에 randomIndex 불러오기
                foodComment.elementAt(foodrandomIndex),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //Horizontal Listview
            Padding(
              padding: const EdgeInsets.only(left: 18.0), //사진폭 18pt 축소
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, bottom: 8.0), //사진폭 8pt 축소
                        child:
                            //Stack 기능
                            Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlaceInfo()),
                                );
                              },
                              child: Container(
                                width: 159, //실제 너비 = 159-26 = 133
                                height: double.infinity, //실제 사진 높이 = 220 - 8*5
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.grey,
                                  //사진 삽입
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${(snapshot.data! as QuerySnapshot).docs[index]['url']}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 159,
                              height: double.infinity, //실제 사진 높이 = 220 - 8*5
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                  gradient: LinearGradient(
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [
                                        Colors.grey.withOpacity(0.0),
                                        Colors.black.withOpacity(0.6),
                                      ],
                                      stops: [
                                        0.0,
                                        0.8,
                                      ])),
                            ),

                            Positioned(
                              top: 5,
                              right: 5,
                              child: InkWell(
                                onTap: () {
                                  //하트 클릭시
                                  //food.isFavorite = !food.isFavorite;
                                  //tripService.updateFood(food, index);
                                },
                                child: Container(
                                  height: 27,
                                  width: 27,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  //child: (food.isFavorite)
                                  //    ? Icon(
                                  //        Icons.favorite_border,
                                  //        color: Colors.white,
                                  //        size: 24,
                                  //      )
                                  //    : Icon(
                                  //        Icons.favorite,
                                  //        color: Color.fromRGBO(
                                  //            234, 83, 36, 1),
                                  //        size: 24,
                                  //      ),
                                ),
                              ),
                            ),
                            //맛집 이름
                            Positioned(
                              bottom: 30,
                              left: 5,
                              child: Text(
                                "${(snapshot.data! as QuerySnapshot).docs[index]['name']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            //맛집 주소
                            Positioned(
                              bottom: 15,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5, top: 2),
                                child: Text(
                                  '${(snapshot.data! as QuerySnapshot).docs[index]['area']}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[400]!,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        );
      },
    );
  }
}
