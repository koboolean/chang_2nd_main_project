import 'dart:async';

import 'package:chang_2nd_main_project/services/event_service.dart';
import 'package:chang_2nd_main_project/services/favorite_button.dart';
import 'package:chang_2nd_main_project/services/firebase_analytics.dart';
import 'package:chang_2nd_main_project/services/travel_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

/// 음식점 상세 설명 페이지
class FoodInfo extends StatefulWidget {
  var foodtoreceive;

  FoodInfo({Key? key, required this.foodtoreceive}) : super(key: key);

  @override
  State<FoodInfo> createState() => _FoodInfoState();
}

class _FoodInfoState extends State<FoodInfo> {
  TextEditingController jobController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //readmore 버튼 초기화
    context.read<TravelService>().isReadMore = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;

    return Consumer(
      builder: (context, travelService, child) {
        return Scaffold(
          //appbar
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,
            backgroundColor: Colors.black,
            centerTitle: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                //appabar 배경 이미지
                image: DecorationImage(
                    image: NetworkImage(widget.foodtoreceive.foodUrl1),
                    fit: BoxFit.cover,
                    //이미지 어두운 필터 씌우기
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken)),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: Icon(
                    Icons.ios_share,
                    size: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    //공유 이벤트 발생
                    firebaseAnalyticsLog(user.uid, "Share()");
                    Share.share(
                        "[SOLT]\n${user.displayName}님께서 장소를 공유하셨어요\n${widget.foodtoreceive.foodAddress}\n[음식점명 : ${widget.foodtoreceive.foodName}]");
                  },
                ),
              ),
              // Consumer<FavoriteButton>(
              //   builder: (context, favoriteButton, child) {
              //     var favoriteFoodList = favoriteButton.favoriteFoodList;
              //     return Padding(
              //       padding: const EdgeInsets.only(right: 16.0),
              //       /*child: IconButton(
              //         onPressed: () {
              //           favoriteButton
              //               .favoriteFoodButton(widget.foodtoreceive.foodIdx);
              //         },
              //         icon: favoriteFoodList
              //                 .contains(widget.foodtoreceive.foodIdx)
              //             ? SvgPicture.asset(
              //                 'assets/images/hearTrue.svg',
              //                 width: 27,
              //                 height: 27,
              //               )
              //             : SvgPicture.asset(
              //                 'assets/images/heartFalse.svg',
              //                 width: 27,
              //                 height: 27,
              //               ),
              //       ),*/
              //     );
              //   },
              // ),
            ],
            // Appbar 하단 음식점 정보
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(160),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //음식점 이름
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        widget.foodtoreceive.foodName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //음식점 주소
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        widget.foodtoreceive.foodAddress,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    //해쉬태그 아이콘 & 길 안내
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 8, 10),
                            height: 23,
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey[400]!.withOpacity(0.4),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "#${widget.foodtoreceive.foodClassification}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //두번째 해시태그 아이콘, 필요시 width 지정하여 사용
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 8, 10),
                            height: 23,
                            width: 0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white.withOpacity(0.6),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Body
          body: Consumer<TravelService>(
            builder: (context, travelService, child) {
              return FutureBuilder<QuerySnapshot>(
                future: travelService
                    .businessHourData(widget.foodtoreceive.foodIdx),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var hourDocs = snapshot.data?.docs ?? [];
                    var hours = hourDocs[0].get('businessHours').toString();
                    var breakTime = hourDocs[0].get('breaktime_LO').toString();
                    List<String> vHours = hours.split(',');

                    List<String> businessHours = [];

                    for (var i in vHours) {
                      var hurs = i.substring(0, 1) == " " ? i.substring(1) : i;
                      businessHours.add(hurs);
                    }

                    String lineNumbering = hours.replaceAll(',', '\n');
                    String currentDate = DateFormat('E', 'ko')
                        .format(DateTime.now())
                        .toString(); //현재 요일

                    final todate = businessHours.indexWhere(
                        (element) => element.startsWith(currentDate));
                    final maxLines = travelService.isReadMore
                        ? 1
                        : '\n'.allMatches(lineNumbering).length + 4;
                    final overFlow = travelService.isReadMore
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis;
                    var isReadMore = travelService.isReadMore;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 19),
                          ListTile(
                            dense: true, // 리스트타일에서 수직 밀도를 맞춤
                            onTap: () {
                              travelService.readMoreButton();
                            },
                            leading: Text(
                              "영업 시간",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            title: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 317,
                                ),
                                Text(
                                  businessHours[todate],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(isReadMore
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up),
                          ),
                          if (!isReadMore)
                            Row(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        230),
                                Text(
                                  lineNumbering + '\n' + breakTime,
                                  maxLines: maxLines,
                                  overflow: overFlow,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5),
                                ),
                              ],
                            ),
                          ListTile(
                            // isThreeLine: true,
                            dense: true, // 리스트타일에서 수직 밀도를 맞춤
                            leading: Text(
                              "주요 메뉴 가격",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            title: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 345,
                                ),
                                Text(
                                  '${widget.foodtoreceive.foodPrice} 원',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: 7,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 243, 243, 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18, top: 24, bottom: 16.0, right: 18),
                            child: Text(
                              widget.foodtoreceive.foodSubtitle,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 18.0),
                            child: Container(
                              width: double.infinity,
                              height: 216,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image(
                                  image: NetworkImage(
                                    widget.foodtoreceive.foodUrl2,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          //음식 설명
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(widget.foodtoreceive.foodDescription),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(),
                    );
                  }
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromRGBO(221, 81, 37, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.turn_slight_right),
                  Text(
                    '길안내',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
              onPressed: () async {
                //음식점 길안내 로직
                firebaseAnalyticsLog(user.uid, "Tmap foodGuide");
                final idx = widget.foodtoreceive.foodIdx;

                final geocode = FirebaseFirestore.instance
                    .collection('geocode_foodArea')
                    .where('idx', isEqualTo: idx);
                final geoValue = await geocode.get();

                final latLong = geoValue.docs.toList();
                final lat = latLong[0]['lat'];
                final long = latLong[0]['long'];

                final Uri toLaunch = Uri.parse(
                    'https://apis.openapi.sk.com/tmap/app/routes?appKey=l7xx3644da34d8ad4b5c9b34f5610c111a16&name=${widget.foodtoreceive.foodName}&lon=${long}&lat=${lat}');
                _launchInBrowser(toLaunch);
              }),
        );
      },
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $url';
      }
    } else {
      print("Can't launch $url");
    }
  }
}

class LodgeInfo extends StatefulWidget {
  var lodgetoreceive;

  LodgeInfo({Key? key, required this.lodgetoreceive}) : super(key: key);

  @override
  State<LodgeInfo> createState() => _LodgeInfoState();
}

class _LodgeInfoState extends State<LodgeInfo> {
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return Consumer(
      builder: (context, travelService, child) {
        return Scaffold(
          //appbar
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,
            backgroundColor: Colors.black,
            centerTitle: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                //appbar 배경 이미지
                image: DecorationImage(
                    image: NetworkImage(widget.lodgetoreceive.lodgeUrl1),
                    fit: BoxFit.cover,
                    //이미지 어두운 필터 씌우기
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken)),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: Icon(
                    Icons.ios_share,
                    size: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    //공유 이벤트 발생
                    firebaseAnalyticsLog(user.uid, "Share()");
                    Share.share(
                        "[SOLT]\n${user.displayName}님께서 장소를 공유하셨어요\n${widget.lodgetoreceive.lodgeAddress}\n[숙소명 :${widget.lodgetoreceive.lodgeName}]");
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 16.0),
              //   child: Consumer<FavoriteButton>(
              //     builder: (context, favoriteButton, child) {
              //       var favoriteLodgeList = favoriteButton.favoriteLodgeList;
              //       return Padding(
              //         padding: const EdgeInsets.only(right: 16.0),
              //         /*child: IconButton(
              //           onPressed: () {
              //             favoriteButton.favoriteLodgeButton(
              //                 widget.lodgetoreceive.lodgeIdx);
              //           },
              //           icon: favoriteLodgeList
              //                   .contains(widget.lodgetoreceive.lodgeIdx)
              //               ? SvgPicture.asset(
              //                   'assets/images/hearTrue.svg',
              //                   width: 27,
              //                   height: 27,
              //                 )
              //               : SvgPicture.asset(
              //                   'assets/images/heartFalse.svg',
              //                   width: 27,
              //                   height: 27,
              //                 ),
              //         ),*/
              //       );
              //     },
              //   ),
              // ),
            ],
            // Appbar 하단 음식점 정보
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(160),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //음식점 이름
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        widget.lodgetoreceive.lodgeName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //음식점 주소
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        widget.lodgetoreceive.lodgeAddress,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    //해쉬태그 아이콘
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 8, 10),
                            height: 23,
                            width: 68,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey[400]!.withOpacity(0.4),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "#${widget.lodgetoreceive.lodgeArea}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ),

                        //두번째 해시태그 아이콘, 필요시 width 지정하여 사용
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 8, 10),
                            height: 23,
                            width: 0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white.withOpacity(0.6),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Body
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 19),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: SizedBox(
                        height: 25,
                        width: 100,
                        child: Text(
                          "영업 시간",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        widget.lodgetoreceive.lodgeBusinessHours,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: SizedBox(
                        height: 25,
                        width: 100,
                        child: Text(
                          "전화번호",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                      width: 200,
                      child: Text(
                        widget.lodgetoreceive.lodgePhoneNumber,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: SizedBox(
                        height: 25,
                        width: 100,
                        child: Text(
                          "가격",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                      width: 200,
                      child: Text(
                        widget.lodgetoreceive.lodgePriceType1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  height: 7,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 243, 243, 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0, top: 24, bottom: 16.0, right: 18.0),
                  child: Text(
                    widget.lodgetoreceive.lodgeSubtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Container(
                    width: double.infinity,
                    height: 216,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image(
                        image: NetworkImage(
                          widget.lodgetoreceive.lodgeUrl2,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                //음식 설명
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(widget.lodgetoreceive.lodgeName),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromRGBO(221, 81, 37, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.turn_slight_right),
                  Text(
                    '길안내',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
              onPressed: () async {
                //음식점 길안내 로직
                firebaseAnalyticsLog(user.uid, "Tmap foodGuide");
                final idx = widget.lodgetoreceive.lodgeIdx;

                final geocode = FirebaseFirestore.instance
                    .collection('geocode_lodgeArea')
                    .where('idx', isEqualTo: idx);
                final geoValue = await geocode.get();

                final latLong = geoValue.docs.toList();
                final lat = latLong[0]['lat'];
                final long = latLong[0]['long'];

                final Uri toLaunch = Uri.parse(
                    'https://apis.openapi.sk.com/tmap/app/routes?appKey=l7xx3644da34d8ad4b5c9b34f5610c111a16&name=${widget.lodgetoreceive.lodgeName}&lon=${long}&lat=${lat}');
                _launchInBrowser(toLaunch);
              }),
        );
      },
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $url';
      }
    } else {
      print("Can't launch $url");
    }
  }
}

class PlaceInfo extends StatefulWidget {
  var placetoreceive;

  PlaceInfo({Key? key, required this.placetoreceive}) : super(key: key);

  @override
  State<PlaceInfo> createState() => _PlaceInfoState();
}

class _PlaceInfoState extends State<PlaceInfo> {
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    final box = context.findRenderObject();
    return Consumer(
      builder: (context, travelService, child) {
        return Scaffold(
          //appbar
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,
            backgroundColor: Colors.black,
            centerTitle: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                //appabar 배경 이미지
                image: DecorationImage(
                    image: NetworkImage(widget.placetoreceive.placeUrl1),
                    fit: BoxFit.cover,
                    //이미지 어두운 필터 씌우기
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken)),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: Icon(
                    Icons.ios_share,
                    size: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    //공유 이벤트 발생
                    firebaseAnalyticsLog(user.uid, "Share()");
                    Share.share(
                      "[SOLT]\n${user.displayName}님께서 장소를 공유하셨어요\n${widget.placetoreceive.placeAddress}\n[관광지명 :${widget.placetoreceive.placeName}]",
                    );
                  },
                ),
              ),
              // Consumer<FavoriteButton>(
              //   builder: (context, favoriteButton, child) {
              //     var favoritePlaceList = favoriteButton.favoritePlaceList;
              //     return Padding(
              //       padding: const EdgeInsets.only(right: 16.0),
              //       /*child: IconButton(
              //         onPressed: () {
              //           favoriteButton.favoritePlaceButton(
              //               widget.placetoreceive.placeIdx);
              //         },
              //         icon: favoritePlaceList
              //                 .contains(widget.placetoreceive.placeIdx)
              //             ? SvgPicture.asset(
              //                 'assets/images/hearTrue.svg',
              //                 width: 27,
              //                 height: 27,
              //               )
              //             : SvgPicture.asset(
              //                 'assets/images/heartFalse.svg',
              //                 width: 27,
              //                 height: 27,
              //               ),
              //       ),*/
              //     );
              //   },
              // ),
            ],
            // Appbar 하단 음식점 정보
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(160),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //음식점 이름
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        widget.placetoreceive.placeName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //음식점 주소
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        widget.placetoreceive.placeAddress,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    //해쉬태그 아이콘
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 8, 10),
                            height: 23,
                            width: 64,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey[400]!.withOpacity(0.4),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "#${widget.placetoreceive.placeClassifiaction}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //두번째 해시태그 아이콘, 필요시 width 지정하여 사용
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 8, 10),
                            height: 23,
                            width: 0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white.withOpacity(0.6),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Body
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 19),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: SizedBox(
                        height: 25,
                        width: 100,
                        child: Text(
                          "운영 시간",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        widget.placetoreceive.placeBusinessHours,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: SizedBox(
                        height: 25,
                        width: 100,
                        child: Text(
                          "전화번호",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        widget.placetoreceive.placePhoneNumber,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: SizedBox(
                        height: 25,
                        width: 100,
                        child: Text(
                          "가격",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        widget.placetoreceive.placePrice,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  height: 7,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 243, 243, 1),
                  ),
                ),
                //장소 한줄 설명
                Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0, top: 24, bottom: 16.0, right: 18.0),
                  child: Text(
                    widget.placetoreceive.placeSubtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Container(
                    width: double.infinity,
                    height: 216,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image(
                        image: NetworkImage(
                          widget.placetoreceive.placeUrl2,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                //음식 설명
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(widget.placetoreceive.placeName),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromRGBO(221, 81, 37, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.turn_slight_right),
                  Text(
                    '길안내',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
              onPressed: () async {
                //음식점 길안내 로직
                firebaseAnalyticsLog(user.uid, "Tmap foodGuide");
                final idx = widget.placetoreceive.placeIdx;

                final geocode = FirebaseFirestore.instance
                    .collection('geocode_lodgeArea')
                    .where('idx', isEqualTo: idx);
                final geoValue = await geocode.get();

                final latLong = geoValue.docs.toList();
                final lat = latLong[0]['lat'];
                final long = latLong[0]['long'];

                final Uri toLaunch = Uri.parse(
                    'https://apis.openapi.sk.com/tmap/app/routes?appKey=l7xx3644da34d8ad4b5c9b34f5610c111a16&name=${widget.placetoreceive.placeName}&lon=${long}&lat=${lat}');
                _launchInBrowser(toLaunch);
              }),
        );
      },
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $url';
      }
    } else {
      print("Can't launch $url");
    }
  }
}
