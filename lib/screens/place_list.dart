// import 'package:chang_2nd_main_project/screens/favorite_list.dart';
import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/screens/search_page.dart';
import 'package:chang_2nd_main_project/widgets/tobeContinue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chang_2nd_main_project/services/travel_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import 'package:chang_2nd_main_project/model/foodToSend.dart';
import 'package:chang_2nd_main_project/model/lodgeToSend.dart';
import 'package:chang_2nd_main_project/model/placeToSend.dart';

/// 홈페이지
class PlaceList extends StatefulWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  State<PlaceList> createState() => _PlaceListState();
}

//선택한 지역 뿌려주는 String 타입 연산자 생성
class SendSelectedValue {
  final String sendSelectedValue;
  const SendSelectedValue(this.sendSelectedValue);
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
        //보낼 연산자 변수 설정
        String sendSelectedValue = _selectedValue;
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
                leading: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: BackButton(
                    color: Colors.black,
                  ),
                ),
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
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MySearch(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
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
                        //dropdown 레이아웃
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: DropdownButton(
                              elevation: 0,
                              underline: Container(height: 0),
                              value: _selectedValue,
                              items: _valueList.map(
                                (value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                          indicatorColor: Color.fromRGBO(221, 81, 37, 1),
                          labelColor: Color.fromRGBO(221, 81, 37, 1),
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
              body: TabBarView(
                children: [
                  FoodList(
                    sendSelectedValue: _selectedValue,
                  ),
                  LodgeList(
                    sendSelectedValue: _selectedValue,
                  ),
                  PlacetogoList(
                    sendSelectedValue: _selectedValue,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// 맛집 tabBody
class FoodList extends StatefulWidget {
  const FoodList({Key? key, required this.sendSelectedValue}) : super(key: key);

  final String sendSelectedValue;

  @override
  State<FoodList> createState() => _FoodListState();
}

//선택한 음식점 분류 기본값 전체로 정의
var _selectedFoodClassification = "전체";

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    //선택한 음식점 아이콘 정의
    String sendFoodClass = _selectedFoodClassification;
    // 전체 Column 구조
    return Consumer<TravelService>(
      builder: (context, travelService, child) {
        return StreamBuilder<QuerySnapshot>(
          //조건에 맞는 지역만 불러오도록 필터링
          stream: travelService.filtering(
              'foodArea', widget.sendSelectedValue, sendFoodClass),
          builder: (context, snapshot) {
            //document를 firebase database에서 불러옴
            final documents = snapshot.data?.docs ?? [];

            //foodArea의 index로 number index list 생성
            List<int> ramdomfoodIndexList =
                List<int>.generate(documents.length, (index) => index);

            //foodArea index list를 shuffle하여 랜덤 음식점 리스트 호출
            ramdomfoodIndexList.shuffle();

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error loading data: ${snapshot.error!}');
            }
            return Column(
              children: [
                SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Container(
                    height: 32,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFoodClassification = "전체";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedFoodClassification == "전체"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "전체",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: _selectedFoodClassification == "전체"
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFoodClassification = "한식";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedFoodClassification == "한식"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "한식",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: _selectedFoodClassification == "한식"
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFoodClassification = "양식";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedFoodClassification == "양식"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "양식",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: _selectedFoodClassification == "양식"
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFoodClassification = "일식";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedFoodClassification == "일식"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "일식",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: _selectedFoodClassification == "일식"
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFoodClassification = "중식";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedFoodClassification == "중식"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "중식",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: _selectedFoodClassification == "중식"
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFoodClassification = "카페";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedFoodClassification == "카페"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "카페",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: _selectedFoodClassification == "카페"
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFoodClassification = "기타";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedFoodClassification == "기타"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "기타",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: _selectedFoodClassification == "기타"
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // 키워드에 따른 음식점 리스트
                Expanded(
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      //랜덤 음식점 index 호출하여 음식점 무작위 나열
                      final doc = documents[ramdomfoodIndexList[index]];
                      FoodToSend foodtosend = FoodToSend(
                          foodSubtitle: doc.get('Subtitle'),
                          foodAddress: doc.get('address'),
                          foodBusinessHours: doc.get('businessHours'),
                          foodClassification: doc.get('classification'),
                          foodField14: doc.get('field14'),
                          foodIdx: doc.get('idx'),
                          foodName: doc.get('name'),
                          foodNaverLink: doc.get('naverlink'),
                          foodNote: doc.get('note'),
                          foodPhonenumber: doc.get('phoneNumber'),
                          foodPrice: doc.get('price'),
                          foodServingSize: doc.get('servingSize'),
                          foodUrl1: doc.get('url1'),
                          foodUrl2: doc.get('url2'));
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
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FoodInfo(
                                                foodtoreceive: foodtosend,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.grey,

                                      //사진 삽입
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(foodtosend.foodUrl1!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    width: double.maxFinite,
                                    height: 142, //실제 높이 142-16 = 126
                                  ),
                                ),
                              ),
                              // 하트 아이콘
                              /*Positioned(
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
                              ),*/
                              // 해시태그 키워드
                              Positioned(
                                bottom: 10,
                                left: 28,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        "#${foodtosend.foodClassification}",
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
                              foodtosend.foodName!,
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
                              foodtosend.foodAddress!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700]!,
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
          },
        );
      },
    );
  }
}

// 숙소 tabBody
class LodgeList extends StatefulWidget {
  const LodgeList({Key? key, required this.sendSelectedValue})
      : super(key: key);

  final String sendSelectedValue;

  @override
  State<LodgeList> createState() => _LodgeListState();
}

//lodge classification 변수 지정
var _selectedLodgeClassification = "전체";

class _LodgeListState extends State<LodgeList> {
  @override
  Widget build(BuildContext context) {
    //숙소 Classification 변수 지정
    String sendLodgeClass = _selectedLodgeClassification;
    // 전체 Column 구조
    return Consumer<TravelService>(builder: (context, travelService, child) {
      return StreamBuilder<QuerySnapshot>(
          stream: travelService.filtering(
              'lodgeArea', widget.sendSelectedValue, sendLodgeClass),
          builder: (context, snapshot) {
            //document를 firebase database에서 불러옴
            final documents = snapshot.data?.docs ?? [];

            //lodgeArea의 index로 number index 생성
            List<int> ramdomlodgeIndexList =
                List<int>.generate(documents.length, (index) => index);
            //lodgeArea index list를 shuffle하여 랜덤 음식점 리스트 호출
            ramdomlodgeIndexList.shuffle();

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error loading data: ${snapshot.error!}');
            }
            return Column(
              children: [
                SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Container(
                    height: 32,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedLodgeClassification = "전체";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedLodgeClassification == "전체"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "전체",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          _selectedLodgeClassification == "전체"
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedLodgeClassification = "1인실";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedLodgeClassification == "1인실"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "1인실",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          _selectedLodgeClassification == "1인실"
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedLodgeClassification = "다인실";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedLodgeClassification == "다인실"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "다인실",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          _selectedLodgeClassification == "다인실"
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // 키워드에 따른 음식점 리스트
                Expanded(
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final doc = documents[ramdomlodgeIndexList[index]];

                      //Firestore 인덱스 가져오기

                      final lodgetosend = LodgeToSend(
                          lodgeBreakFastYn: doc.get('BreakfastYn'),
                          lodgeSubtitle: doc.get('Subtitle'),
                          lodgeAddress: doc.get('address'),
                          lodgeArea: doc.get('area'),
                          lodgeBusinessHours: doc.get('businessHours'),
                          lodgeIdx: doc.get('idx'),
                          lodgeName: doc.get('name'),
                          lodgeNaverLink: doc.get('naverlink'),
                          lodgePartyYn: doc.get('partyYn'),
                          lodgePhoneNumber: doc.get('phoneNumber'),
                          lodgePriceType1: doc.get('priceType1'),
                          lodgePriceType2: doc.get('priceType2'),
                          lodgePriceType3: doc.get('priceType3'),
                          lodgeToiletYn: doc.get('toiletYn'),
                          lodgeUrl1: doc.get('url1'),
                          lodgeUrl2: doc.get('url2'));
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
                                child: GestureDetector(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LodgeInfo(
                                                lodgetoreceive: lodgetosend,
                                              )),
                                    );
                                  }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.grey,

                                      //사진 삽입
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            lodgetosend.lodgeUrl1!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    width: double.maxFinite,
                                    height: 142, //실제 높이 142-16 = 126
                                  ),
                                ),
                              ),
                              // 하트 아이콘
                              /*Positioned(
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
                                          // ),ㄴ
                                          Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),*/
                              // 해시태그 키워드
                              Positioned(
                                bottom: 10,
                                left: 28,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        "#${lodgetosend.lodgePriceType3}",
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
                              lodgetosend.lodgeName!,
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
                              lodgetosend.lodgeAddress!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700]!,
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
    });
  }
}

// Place tabBody
class PlacetogoList extends StatefulWidget {
  const PlacetogoList({Key? key, required this.sendSelectedValue})
      : super(key: key);

  final String sendSelectedValue;

  @override
  State<PlacetogoList> createState() => _PlacetogoListState();
}

//lodge classification 변수 지정
var _selectedPlaceClassification = "전체";

class _PlacetogoListState extends State<PlacetogoList> {
  @override
  Widget build(BuildContext context) {
    //숙소 Classification 변수 지정
    String sendPlaceClass = _selectedPlaceClassification;
    // 전체 Column 구조
    return Consumer<TravelService>(builder: (context, travelService, child) {
      return StreamBuilder<QuerySnapshot>(
          stream: travelService.filtering(
              'placeArea', widget.sendSelectedValue, sendPlaceClass),
          builder: (context, snapshot) {
            //document를 firebase database에서 불러옴
            final documents = snapshot.data?.docs ?? [];

            //lodgeArea의 index로 number index 생성
            List<int> ramdomplaceIndexList =
                List<int>.generate(documents.length, (index) => index);
            //lodgeArea index list를 shuffle하여 랜덤 음식점 리스트 호출
            ramdomplaceIndexList.shuffle();
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error loading data: ${snapshot.error!}');
            }
            return Column(
              children: [
                SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Container(
                    height: 32,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPlaceClassification = "전체";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedPlaceClassification == "전체"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "전체",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          _selectedPlaceClassification == "전체"
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPlaceClassification = "바다";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedPlaceClassification == "바다"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "바다",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          _selectedPlaceClassification == "바다"
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPlaceClassification = "공원";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedPlaceClassification == "공원"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "공원",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          _selectedPlaceClassification == "공원"
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPlaceClassification = "체험";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedPlaceClassification == "체험"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "체험",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          _selectedPlaceClassification == "체험"
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPlaceClassification = "테마파크";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedPlaceClassification == "테마파크"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "테마파크",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          _selectedPlaceClassification == "테마파크"
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPlaceClassification = "자연명소";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedPlaceClassification == "자연명소"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "자연명소",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          _selectedPlaceClassification == "자연명소"
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPlaceClassification = "관람";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 32,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: _selectedPlaceClassification == "관람"
                                      ? Color.fromRGBO(221, 81, 37, 1)
                                      : Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "관람",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          _selectedPlaceClassification == "관람"
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // 키워드에 따른 음식점 리스트
                Expanded(
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      //랜덤 음식점 index 호출하여 음식점 무작위 나열
                      final doc = documents[ramdomplaceIndexList[index]];
                      final placetosend = PlaceToSend(
                          placeAddress: doc.get('address'),
                          placeArea: doc.get('area'),
                          placeBusinessHours: doc.get('businessHours'),
                          placeClassifiaction: doc.get('classification'),
                          placeField13: doc.get('field13'),
                          placeIdx: doc.get('idx'),
                          placeName: doc.get('name'),
                          placeNaverLink: doc.get('naverlink'),
                          placeNote: doc.get('note'),
                          placePhoneNumber: doc.get('phoneNumber'),
                          placePrice: doc.get('price'),
                          placeSubtitle: doc.get('subTitle'),
                          placeUrl1: doc.get('url1'),
                          placeUrl2: doc.get('url2'));

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
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PlaceInfo(
                                                placetoreceive: placetosend,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.grey,

                                      //사진 삽입
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            placetosend.placeUrl1!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    width: double.maxFinite,
                                    height: 142, //실제 높이 142-16 = 126
                                  ),
                                ),
                              ),
                              // 하트 아이콘
                              /*Positioned(
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
                                ),*/
                              // 해시태그 키워드
                              Positioned(
                                bottom: 10,
                                left: 28,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        "#${placetosend.placeArea}",
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
                              placetosend.placeName!,
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
                              placetosend.placeAddress!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700]!,
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
    });
  }
}
