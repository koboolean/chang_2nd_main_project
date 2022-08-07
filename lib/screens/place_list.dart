import 'package:chang_2nd_main_project/screens/favorite_list.dart';
import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:chang_2nd_main_project/screens/notification.dart';
import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/screens/place_list.dart';
import 'package:chang_2nd_main_project/widgets/tobeContinue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chang_2nd_main_project/services/travel_service.dart';
import 'package:chang_2nd_main_project/screens/search_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

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
                        showTobeContinue(context);
                       /* Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MySearch()),
                        );*/
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

// 맛집 Body
class FoodList extends StatefulWidget {
  const FoodList({Key? key, required this.sendSelectedValue}) : super(key: key);

  final String sendSelectedValue;

  @override
  State<FoodList> createState() => _FoodListState();
}

//place_info에 송부할 데이터 list 생성
class FoodToSend {
  final String foodSubtitle;
  final String foodAddress;
  final String foodArea;
  final String foodBusinessHours;
  final String foodClassification;
  final String foodField14;
  final String foodIdx;
  final String foodName;
  final String foodNaverLink;
  final String foodNote;
  final String foodPhonenumber;
  final String foodPrice;
  final String foodServingSize;
  final String foodUrl1;
  final String foodUrl2;

  const FoodToSend(
      this.foodSubtitle,
      this.foodAddress,
      this.foodArea,
      this.foodBusinessHours,
      this.foodClassification,
      this.foodField14,
      this.foodIdx,
      this.foodName,
      this.foodNaverLink,
      this.foodNote,
      this.foodPhonenumber,
      this.foodPrice,
      this.foodServingSize,
      this.foodUrl1,
      this.foodUrl2);
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    // 전체 Column 구조
    return StreamBuilder<QuerySnapshot>(
        //조건에 맞는 지역만 불러오도록 필터링
        stream: FirebaseFirestore.instance
            .collection('foodArea')
            .where('area',
                isEqualTo: widget.sendSelectedValue == "전체"
                    ? null
                    : widget.sendSelectedValue)
            .snapshots(),
        builder: (context, snapshot) {
          //document를 firebase database에서 불러옴
          final documents = snapshot.data?.docs ?? [];

          //foodArea의 index로 number index list 생성
          List<int> ramdomfoodIndexList =
              List<int>.generate(documents.length, (index) => index);

          //foodArea index list를 shuffle하여 랜덤 음식점 리스트 호출
          ramdomfoodIndexList.shuffle();

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
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    //랜덤 음식점 index 호출하여 음식점 무작위 나열
                    final doc = documents[ramdomfoodIndexList[index]];

                    //Firestore 인덱스 가져오기
                    String foodSubtitle = doc.get('Subtitle');
                    String foodAddress = doc.get('address');
                    String foodBusinessHours = doc.get('businessHours');
                    String foodClassification = doc.get('classification');
                    String foodField14 = doc.get('field14');
                    String foodIdx = doc.get('idx');
                    String foodNaverLink = doc.get('naverlink');
                    String foodNote = doc.get('note');
                    String foodPhonenumber = doc.get('phoneNumber');
                    String foodPrice = doc.get('price');
                    String foodServingSize = doc.get('servingSize');
                    String foodName = doc.get('name');
                    String foodUrl1 = doc.get('url1');
                    String foodUrl2 = doc.get('url2');
                    String foodArea = doc.get('area');

                    final foodtosend = FoodToSend(
                        foodSubtitle,
                        foodAddress,
                        foodArea,
                        foodBusinessHours,
                        foodClassification,
                        foodField14,
                        foodIdx,
                        foodName,
                        foodNaverLink,
                        foodNote,
                        foodPhonenumber,
                        foodPrice,
                        foodServingSize,
                        foodUrl1,
                        foodUrl2);

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
                                      image: NetworkImage(foodUrl1),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: double.maxFinite,
                                  height: 142, //실제 높이 142-16 = 126
                                ),
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
                                      "#$foodClassification",
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
                            foodName,
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
                            foodAddress,
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
  }
}

// 맛집 Body
class LodgeList extends StatefulWidget {
  const LodgeList({Key? key, required this.sendSelectedValue})
      : super(key: key);

  final String sendSelectedValue;

  @override
  State<LodgeList> createState() => _LodgeListState();
}

//place_info에 송부할 데이터 list 생성
class LodgeToSend {
  final String lodgeBreakFastYn;
  final String lodgeSubtitle;
  final String lodgeAddress;
  final String lodgeArea;
  final String lodgeBusinessHours;
  final String lodgeIdx;
  final String lodgeName;
  final String lodgeNaverLink;
  final String lodgePartyYn;
  final String lodgePhoneNumber;
  final String lodgePriceType1;
  final String lodgePriceType2;
  final String lodgePriceType3;
  final String lodgeToiletYn;
  final String lodgeUrl1;
  final String lodgeUrl2;

  const LodgeToSend(
      this.lodgeBreakFastYn,
      this.lodgeSubtitle,
      this.lodgeAddress,
      this.lodgeArea,
      this.lodgeBusinessHours,
      this.lodgeIdx,
      this.lodgeName,
      this.lodgeNaverLink,
      this.lodgePartyYn,
      this.lodgePhoneNumber,
      this.lodgePriceType1,
      this.lodgePriceType2,
      this.lodgePriceType3,
      this.lodgeToiletYn,
      this.lodgeUrl1,
      this.lodgeUrl2);
}

class _LodgeListState extends State<LodgeList> {
  @override
  Widget build(BuildContext context) {
    // 전체 Column 구조
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('lodgeArea')
            .where('area',
                isEqualTo: widget.sendSelectedValue == "전체"
                    ? null
                    : widget.sendSelectedValue)
            .snapshots(),
        builder: (context, snapshot) {
          //document를 firebase database에서 불러옴
          final documents = snapshot.data?.docs ?? [];

          //lodgeArea의 index로 number index 생성
          List<int> ramdomlodgeIndexList =
              List<int>.generate(documents.length, (index) => index);
          //lodgeArea index list를 shuffle하여 랜덤 음식점 리스트 호출
          ramdomlodgeIndexList.shuffle();

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
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final doc = documents[ramdomlodgeIndexList[index]];

                    //Firestore 인덱스 가져오기
                    String lodgeBreakFastYn = doc.get('BreakfastYn');
                    String lodgeSubtitle = doc.get('Subtitle');
                    String lodgeAddress = doc.get('address');
                    String lodgeArea = doc.get('area');
                    String lodgeBusinessHours = doc.get('businessHours');
                    String lodgeIdx = doc.get('idx');
                    String lodgeName = doc.get('name');
                    String lodgeNaverLink = doc.get('naverlink');
                    String lodgePartyYn = doc.get('partyYn');
                    String lodgePhoneNumber = doc.get('phoneNumber');
                    String lodgePriceType1 = doc.get('priceType1');
                    String lodgePriceType2 = doc.get('priceType2');
                    String lodgePriceType3 = doc.get('priceType3');
                    String lodgeToiletYn = doc.get('toiletYn');
                    String lodgeUrl1 = doc.get('url1');
                    String lodgeUrl2 = doc.get('url2');

                    final lodgetosend = LodgeToSend(
                        lodgeBreakFastYn,
                        lodgeSubtitle,
                        lodgeAddress,
                        lodgeArea,
                        lodgeBusinessHours,
                        lodgeIdx,
                        lodgeName,
                        lodgeNaverLink,
                        lodgePartyYn,
                        lodgePhoneNumber,
                        lodgePriceType1,
                        lodgePriceType2,
                        lodgePriceType3,
                        lodgeToiletYn,
                        lodgeUrl1,
                        lodgeUrl2);
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
                                      image: NetworkImage(lodgeUrl1),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: double.maxFinite,
                                  height: 142, //실제 높이 142-16 = 126
                                ),
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
                                      "#$lodgePriceType3",
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
                            lodgeName,
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
                            lodgeAddress,
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
  }
}

// 맛집 Body
class PlacetogoList extends StatefulWidget {
  const PlacetogoList({Key? key, required this.sendSelectedValue})
      : super(key: key);

  final String sendSelectedValue;

  @override
  State<PlacetogoList> createState() => _PlacetogoListState();
}

class PlaceToSend {
  final String placeAddress;
  final String placeArea;
  final String placeBusinessHours;
  final String placeClassifiaction;
  final String placeField13;
  final String placeIdx;
  final String placeName;
  final String placeNaverLink;
  final String placeNote;
  final String placePhoneNumber;
  final String placePrice;
  final String placeSubtitle;
  final String placeUrl1;
  final String placeUrl2;

  const PlaceToSend(
      this.placeAddress,
      this.placeArea,
      this.placeBusinessHours,
      this.placeClassifiaction,
      this.placeField13,
      this.placeIdx,
      this.placeName,
      this.placeNaverLink,
      this.placeNote,
      this.placePhoneNumber,
      this.placePrice,
      this.placeSubtitle,
      this.placeUrl1,
      this.placeUrl2);
}

class _PlacetogoListState extends State<PlacetogoList> {
  @override
  Widget build(BuildContext context) {
    // 전체 Column 구조
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('placeArea')
            .where('area',
                isEqualTo: widget.sendSelectedValue == "전체"
                    ? null
                    : widget.sendSelectedValue)
            .snapshots(),
        builder: (context, snapshot) {
          //document를 firebase database에서 불러옴
          final documents = snapshot.data?.docs ?? [];

          //lodgeArea의 index로 number index 생성
          List<int> ramdomplaceIndexList =
              List<int>.generate(documents.length, (index) => index);
          //lodgeArea index list를 shuffle하여 랜덤 음식점 리스트 호출
          ramdomplaceIndexList.shuffle();
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
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    //랜덤 음식점 index 호출하여 음식점 무작위 나열
                    final doc = documents[ramdomplaceIndexList[index]];

                    //Place data 호출
                    String placeAddress = doc.get('address');
                    String placeArea = doc.get('area');
                    String placeBusinessHours = doc.get('businessHours');
                    String placeClassifiaction = doc.get('classification');
                    String placeField13 = doc.get('field13');
                    String placeIdx = doc.get('idx');
                    String placeName = doc.get('name');
                    String placeNaverLink = doc.get('naverlink');
                    String placeNote = doc.get('note');
                    String placePhoneNumber = doc.get('phoneNumber');
                    String placePrice = doc.get('price');
                    String placeSubtitle = doc.get('subTitle');
                    String placeUrl1 = doc.get('url1');
                    String placeUrl2 = doc.get('url2');

                    final placetosend = PlaceToSend(
                        placeAddress,
                        placeArea,
                        placeBusinessHours,
                        placeClassifiaction,
                        placeField13,
                        placeIdx,
                        placeName,
                        placeNaverLink,
                        placeNote,
                        placePhoneNumber,
                        placePrice,
                        placeSubtitle,
                        placeUrl1,
                        placeUrl2); //Firestore 변수 설정

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
                                      image: NetworkImage(placeUrl1),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: double.maxFinite,
                                  height: 142, //실제 높이 142-16 = 126
                                ),
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
                                      "#$placeArea",
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
                            placeName,
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
                            placeAddress,
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
  }
}
