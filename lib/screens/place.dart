// import 'dart:html';
import 'dart:math';

import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/screens/place_list.dart';
import 'package:chang_2nd_main_project/screens/search_page.dart';
import 'package:chang_2nd_main_project/services/favorite_button.dart';
import 'package:chang_2nd_main_project/services/favorite_service.dart';
import 'package:chang_2nd_main_project/services/firebase_analytics.dart';
import 'package:chang_2nd_main_project/services/travel_service.dart';
import 'package:chang_2nd_main_project/widgets/tobeContinue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../services/event_service.dart';
import '../widgets/url_launch.dart';

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
              /*Padding(
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
              ),*/
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///AppBar Title
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      bottom: 13.0,
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

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 0.0, bottom: 18.0),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MySearch(),
                          ),
                        );
                      },
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(246, 246, 246, 1),
                          border: Border.all(
                              width: 1.5,
                              color: Color.fromRGBO(246, 246, 246, 1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "ex. 김녕 바당길(바닷길)",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'SpoqaHanSansNeo',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(196, 196, 196, 1)),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.search, color: Colors.black),
                            SizedBox(
                              width: 14,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// 요즘 인기있는 여행지
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      left: 16,
                      bottom: 14,
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
                GestureDetector(
                  onTap: () {
                    launchInBrowser(Uri.parse(
                        'https://docs.google.com/forms/d/1ZksVpUqnPvmQhCpwLx-NlP5IgTVd6Dkx-Icah6CEVgk/edit?usp=drivesdk'));
                  },
                  child: Image.asset(
                    'assets/images/event_banner1.png',
                    fit: BoxFit.cover,
                    height: 134,
                    width: 339,
                  ),
                ),
                RecommendFoodList(),
                RecommendLodgeList(),
                RecommendPlaceList(),
                SizedBox(
                  height: 90,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Future<void> _launchInBrowser(Uri url) async {
  //   if (await canLaunchUrl(url)) {
  //     if (!await launchUrl(
  //       url,
  //       mode: LaunchMode.externalApplication,
  //     )) {
  //       throw 'Could not launch $url';
  //     }
  //   } else {
  //     //print("Can't launch $url");
  //   }
  // }
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
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 1,
      itemBuilder: ((context, index) {
        return InkWell(
          onTap: () {
            //PlaceList 이동 analytics
            firebaseScreenViewChanged(user.uid, "PlaceList()");
            //해당 페이지 방문 여부
            context.read<EventBanner>().pageVisitClick.add(true);
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

//place_info에 송부할 데이터 list 생성
class FoodToSend {
  final String foodSubtitle;
  final String foodAddress;
  final String foodArea;
  final String foodBusinessHours;
  final String foodClassification;
  final String foodDescription;
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
      this.foodDescription,
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

//음식점 제안 코멘트
final foodComment = <String>{
  '오늘 점심은 여기서! 어때요?',
  '혼밥도 어렵지 않아요!',
  '요즘 혼밥 핫플은 여기에요',
  '1인분 주문도 가능한 식당',
  '오늘 저녁은 혼자서 분위기 있게',
};

//음식점 제안 코멘트 호출용 Random 숫자 생성
int foodcommentrandomIndex = Random().nextInt(4);

class _RecommendFoodListState extends State<RecommendFoodList> {
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('foodArea').snapshots(),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //리스트 설명 텍스트
            Padding(
              padding:
                  const EdgeInsets.only(top: 17.0, left: 18.0, bottom: 15.0),
              child: Text(
                //foodComment에 randomIndex 불러오기
                foodComment.elementAt(foodcommentrandomIndex),
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      //랜덤 음식점 index 호출하여 음식점 무작위 나열
                      final doc = documents[ramdomfoodIndexList[index]];

                      //Firestore 인덱스 가져오기
                      String foodSubtitle = doc.get('Subtitle') ?? "";
                      String foodAddress = doc.get('address') ?? "";
                      String foodBusinessHours = doc.get('businessHours') ?? "";
                      String foodClassification =
                          doc.get('classification') ?? "";
                      String foodDescription = doc.get('description') ?? "";
                      String foodField14 = doc.get('field14') ?? "";
                      String foodIdx = doc.get('idx') ?? "";
                      String foodNaverLink = doc.get('naverlink') ?? "";
                      String foodNote = doc.get('note') ?? "";
                      String foodPhonenumber = doc.get('phoneNumber') ?? "";
                      String foodPrice = doc.get('price') ?? "";
                      String foodServingSize = doc.get('servingSize') ?? "";
                      String foodName = doc.get('name') ?? "";
                      String foodUrl1 = doc.get('url1') ?? "";
                      String foodUrl2 = doc.get('url2') ?? "";
                      String foodArea = doc.get('area') ?? "";
                      String foodDocId = doc.id;

                      final foodtosend = FoodToSend(
                          foodSubtitle,
                          foodAddress,
                          foodArea,
                          foodBusinessHours,
                          foodClassification,
                          foodDescription,
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

                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, bottom: 3.0), //사진폭 8pt 축소
                        child:
                            //Stack 기능
                            Stack(
                          children: [
                            Container(
                              width: 159, //실제 너비 = 159-26 = 133
                              height: 220, //실제 사진 높이 = 220 - 8*5
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
                            ),
                            InkWell(
                              onTap: () {
                                //FoodInfo이동시 analytics 기록
                                firebaseScreenViewChanged(
                                    user.uid, "FoodInfo()");
                                //설문조사 이벤트 place_info페이지 카운트하기
                                var isDoneEvent =
                                    context.read<EventBanner>().eventCheck();

                                if (isDoneEvent == false) {
                                  context
                                      .read<EventBanner>()
                                      .increaseClick(context);
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FoodInfo(
                                            foodtoreceive: foodtosend,
                                          )),
                                );
                              },
                              child: Container(
                                width: 159,
                                height: 220, //실제 사진 높이 = 220 - 8*5
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
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            /*Positioned(
                              top: 5,
                              right: 5,
                              child: InkWell(
                                onTap: () {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;

                                  if (user != null) {
                                    // data 의 name 보내기, favoriteFoodserivce 추가
                                    FavoriteFoodService favoriteFoodService =
                                        context.read<FavoriteFoodService>();

                                    //(하트 on&off) 컬랙션 경로 : foodNameUser/doc/필드
                                    //favorite_list페이지에 사용될 db
                                    favoriteFoodService
                                        .toggleFavoriteFood(foodIdx);
                                    //(하트 on&off) 컬랙션 경로 : foodArea/doc/user/uid필드 db와 연결된 로직
                                    favoriteFoodService.newFoodFavoriteToggle(
                                        user.uid, foodDocId);
                                    //하트 on&off ( 내부 로직 / db연결x db와 별개로 동작 )
                                    context
                                        .read<FavoriteButton>()
                                        .favoriteFoodButton(foodIdx);
                                  }
                                },
                                child: Container(
                                  constraints: BoxConstraints(),
                                  height: 27,
                                  width: 27,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Consumer<FavoriteButton>(
                                    builder: (context, favoriteButton, child) {
                                      var favoriteFoodList =
                                          favoriteButton.favoriteFoodList;

                                      return Container(
                                        width: 27,
                                        height: 27,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child:
                                              favoriteFoodList.contains(foodIdx)
                                                  ? SvgPicture.asset(
                                                      'assets/images/hearTrue.svg',
                                                      width: 27,
                                                      height: 27,
                                                    )
                                                  : SvgPicture.asset(
                                                      'assets/images/heartFalse.svg',
                                                      width: 27,
                                                      height: 27,
                                                    ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),*/
                            //맛집 이름
                            Positioned(
                              bottom: 30,
                              left: 5,
                              child: Text(
                                foodName,
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
                                  foodArea,
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

//숙소 코멘트 및 리스트
class RecommendLodgeList extends StatefulWidget {
  const RecommendLodgeList({Key? key}) : super(key: key);

  @override
  State<RecommendLodgeList> createState() => _RecommendLodgeListState();
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

//숙소 제안 코멘트
final lodgeComment = <String>{
  '편안하게 쉴 수 있는 숙소',
  '휴식과 가성비를 둘다 잡은 숙소',
  '숙소를 아직 정하지 않았다면, 이곳은 어때요?',
  '많이 피곤하시죠? 여기서 푹 쉬고 내일도 활기차게!',
};

//Random 숫자 반환
int lodgerandomIndex = Random().nextInt(3);

class _RecommendLodgeListState extends State<RecommendLodgeList> {
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('lodgeArea').snapshots(),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //리스트 설명 텍스트
            Padding(
              padding:
                  const EdgeInsets.only(top: 17.0, left: 18.0, bottom: 15.0),
              child: Text(
                //foodComment에 randomIndex 불러오기
                lodgeComment.elementAt(lodgerandomIndex),
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      final doc = documents[ramdomlodgeIndexList[index]];

                      //Firestore 인덱스 가져오기
                      String lodgeBreakFastYn = doc.get('BreakfastYn') ?? "";
                      String lodgeSubtitle = doc.get('Subtitle') ?? "";
                      String lodgeAddress = doc.get('address') ?? "";
                      String lodgeArea = doc.get('area') ?? "";
                      String lodgeBusinessHours =
                          doc.get('businessHours') ?? "";
                      String lodgeIdx = doc.get('idx') ?? "";
                      String lodgeName = doc.get('name') ?? "";
                      String lodgeNaverLink = doc.get('naverlink') ?? "";
                      String lodgePartyYn = doc.get('partyYn') ?? "";
                      String lodgePhoneNumber = doc.get('phoneNumber') ?? "";
                      String lodgePriceType1 = doc.get('priceType1') ?? "";
                      String lodgePriceType2 = doc.get('priceType2') ?? "";
                      String lodgePriceType3 = doc.get('priceType3') ?? "";
                      String lodgeToiletYn = doc.get('toiletYn') ?? "";
                      String lodgeUrl1 = doc.get('url1') ?? "";
                      String lodgeUrl2 = doc.get('url2') ?? "";
                      String lodgeDocId = doc.id;

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

                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, bottom: 3.0), //사진폭 8pt 축소
                        child:
                            //Stack 기능
                            Stack(
                          children: [
                            Container(
                              width: 159, //실제 너비 = 159-26 = 133
                              height: 220, //실제 사진 높이 = 220 - 8*5 = 180
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
                            ),

                            InkWell(
                              onTap: () {
                                //LodgeInfo이동시 analytics 기록
                                firebaseScreenViewChanged(
                                    user.uid, "LodgeInfo()");
                                var isDoneEvent =
                                    context.read<EventBanner>().eventCheck();

                                if (isDoneEvent == false) {
                                  context
                                      .read<EventBanner>()
                                      .increaseClick(context);
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LodgeInfo(
                                            lodgetoreceive: lodgetosend,
                                          )),
                                );
                              }, //
                              child: Container(
                                width: 159,
                                height: 220, //실제 사진 높이 = 220 - 8*5
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
                            ),

                            /*Positioned(
                              top: 5,
                              right: 5,
                              child: InkWell(
                                onTap: () {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;

                                  if (user != null) {
                                    // data 의 name 보내기, favoriteFoodserivce 추가
                                    FavoriteLodgeService favoriteLodgeService =
                                        context.read<FavoriteLodgeService>();

                                    //(하트 on&off) 컬랙션 경로 : lodgeNameUser/doc/필드
                                    //favorite_list페이지에 사용될 db
                                    favoriteLodgeService
                                        .toggleFavoriteLodge(lodgeIdx);
                                    //(하트 on&off) 컬랙션 경로 : foodArea/doc/user/uid필드 db와 연결된 로직
                                    favoriteLodgeService.newLodgeFavoriteToggle(
                                        user.uid, lodgeDocId);
                                    //하트 on&off ( 내부 로직 / db연결x db와 별개로 동작 )
                                    context
                                        .read<FavoriteButton>()
                                        .favoriteLodgeButton(lodgeIdx);
                                  }
                                },
                                child: Container(
                                    height: 27,
                                    width: 27,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Consumer<FavoriteButton>(
                                      builder:
                                          (context, favoriteButton, child) {
                                        var favoriteLodgeList =
                                            favoriteButton.favoriteLodgeList;

                                        return Container(
                                          width: 27,
                                          height: 27,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: favoriteLodgeList
                                                    .contains(lodgeIdx)
                                                ? SvgPicture.asset(
                                                    'assets/images/hearTrue.svg',
                                                    width: 27,
                                                    height: 27,
                                                  )
                                                : SvgPicture.asset(
                                                    'assets/images/heartFalse.svg',
                                                    width: 27,
                                                    height: 27,
                                                  ),
                                          ),
                                        );
                                      },
                                    )
                                ),
                              ),
                            ),*/
                            //맛집 이름
                            Positioned(
                              bottom: 30,
                              left: 5,
                              child: Text(
                                lodgeName,
                                overflow: TextOverflow.clip,
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
                                  lodgeArea,
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

//관광지 코멘트 및 리스트
class RecommendPlaceList extends StatefulWidget {
  const RecommendPlaceList({Key? key}) : super(key: key);

  @override
  State<RecommendPlaceList> createState() => _RecommendPlaceListState();
}

//place_info에 송부할 데이터 list 생성
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

//숙소 제안 코멘트
final placeComment = <String>{
  '오늘 여행지는 여기!',
  '여행을 떠나볼까요?',
  '여행일정이 빈다면, 이곳을 들러보세요!',
};

//Random 숫자 반환
int placerandomIndex = Random().nextInt(2);

class _RecommendPlaceListState extends State<RecommendPlaceList> {
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('placeArea').snapshots(),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //리스트 설명 텍스트
            Padding(
              padding:
                  const EdgeInsets.only(top: 17.0, left: 18.0, bottom: 15.0),
              child: Text(
                //foodComment에 randomIndex 불러오기
                placeComment.elementAt(placerandomIndex),
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      //랜덤 음식점 index 호출하여 음식점 무작위 나열
                      final doc = documents[ramdomplaceIndexList[index]];

                      //Place data 호출
                      String placeAddress = doc.get('address') ?? "";
                      String placeArea = doc.get('area') ?? "";
                      String placeBusinessHours =
                          doc.get('businessHours') ?? "";
                      String placeClassifiaction =
                          doc.get('classification') ?? "";
                      String placeField13 = doc.get('field13') ?? "";
                      String placeIdx = doc.get('idx') ?? "";
                      String placeName = doc.get('name') ?? "";
                      String placeNaverLink = doc.get('naverlink') ?? "";
                      String placeNote = doc.get('note') ?? "";
                      String placePhoneNumber = doc.get('phoneNumber') ?? "";
                      String placePrice = doc.get('price') ?? "";
                      String placeSubtitle = doc.get('subTitle') ?? "";
                      String placeUrl1 = doc.get('url1') ?? "";
                      String placeUrl2 = doc.get('url2') ?? "";
                      String placeDocId = doc.id;

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
                          placeUrl2);

                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, bottom: 3.0), //사진폭 8pt 축소
                        child:
                            //Stack 기능
                            Stack(
                          children: [
                            Container(
                              width: 159, //실제 너비 = 159-26 = 133
                              height: 220, //실제 사진 높이 = 220 - 8*5 = 180
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
                            ),
                            //음영 및 Gradient 효과 layer
                            InkWell(
                              //PlaceInfo이동시 analytics 기록
                              onTap: () {
                                firebaseScreenViewChanged(
                                    user.uid, "PlaceInfo()");
                                var isDoneEvent =
                                    context.read<EventBanner>().eventCheck();
                                if (isDoneEvent == false) {
                                  context
                                      .read<EventBanner>()
                                      .increaseClick(context);
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlaceInfo(
                                            placetoreceive: placetosend,
                                          )),
                                );
                              },
                              child: Container(
                                width: 159,
                                height: 220, //실제 사진 높이 = 220 - 8*5
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            /*Positioned(
                              top: 5,
                              right: 5,
                              child: InkWell(
                                onTap: () {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;

                                  if (user != null) {
                                    // data 의 name 보내기, favoritePlaceserivce 추가
                                    FavoritePlaceService favoritePlaceService =
                                        context.read<FavoritePlaceService>();
                                    //(하트 on&off) 컬랙션 경로 : placeNameUser/doc/필드
                                    //favorite_list페이지에 사용될 db
                                    favoritePlaceService
                                        .toggleFavoritePlace(placeIdx);
                                    //(하트 on&off) 컬랙션 경로 : placeArea/doc/user/uid필드 db와 연결된 로직
                                    favoritePlaceService.newPlaceFavoriteToggle(
                                        user.uid, placeDocId);
                                    //하트 on&off ( 내부 로직 / db연결x db와 별개로 동작 )
                                    context
                                        .read<FavoriteButton>()
                                        .favoritePlaceButton(placeIdx);
                                  }
                                },
                                child: Container(
                                  constraints: BoxConstraints(),
                                  height: 27,
                                  width: 27,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Consumer<FavoriteButton>(
                                    builder: (context, favoriteButton, child) {
                                      var favoritePlaceList =
                                          favoriteButton.favoritePlaceList;
                                      return Container(
                                        width: 27,
                                        height: 27,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: favoritePlaceList
                                                  .contains(placeIdx)
                                              ? SvgPicture.asset(
                                                  'assets/images/hearTrue.svg',
                                                  width: 27,
                                                  height: 27,
                                                )
                                              : SvgPicture.asset(
                                                  'assets/images/heartFalse.svg',
                                                  width: 27,
                                                  height: 27,
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),*/
                            //맛집 이름
                            Positioned(
                              bottom: 30,
                              left: 5,
                              child: Text(
                                placeName,
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
                                  placeArea,
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
