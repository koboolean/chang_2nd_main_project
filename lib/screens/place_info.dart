import 'package:chang_2nd_main_project/screens/favorite_list.dart';
import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:chang_2nd_main_project/screens/notification.dart';
import 'package:chang_2nd_main_project/screens/place.dart';
import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/screens/place_list.dart';
import 'package:chang_2nd_main_project/services/travel_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

/// 음식점 상세 설명 페이지
class FoodInfo extends StatefulWidget {
  final FoodToSend foodtosend;
  FoodInfo({Key? key, required this.foodtosend}) : super(key: key);

  @override
  State<FoodInfo> createState() => _FoodInfoState();
}

class _FoodInfoState extends State<FoodInfo> {
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
                //appabar 배경 이미지
                image: DecorationImage(
                    image: NetworkImage(widget.foodtosend.foodUrl1),
                    fit: BoxFit.cover,
                    //이미지 어두운 필터 씌우기
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken)),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.ios_share,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 24,
                ),
              ),
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
                        widget.foodtosend.foodName,
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
                        widget.foodtosend.foodAddress,
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
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey[400]!.withOpacity(0.4),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "#${widget.foodtosend.foodClassification}",
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
                        widget.foodtosend.foodBusinessHours,
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
                          "주요 메뉴 가격",
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
                        "${widget.foodtosend.foodPrice} 원",
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
                          "1인분 주문",
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
                        widget.foodtosend.foodServingSize,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // 중간 회색 바
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
                    widget.foodtosend.foodSubtitle,
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
                          widget.foodtosend.foodUrl2,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                //음식 설명
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(widget.foodtosend.foodNote),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LodgeInfo extends StatefulWidget {
  final LodgeToSend lodgetosend;
  LodgeInfo({Key? key, required this.lodgetosend}) : super(key: key);

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
                    image: NetworkImage(widget.lodgetosend.lodgeUrl1),
                    fit: BoxFit.cover,
                    //이미지 어두운 필터 씌우기
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken)),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.ios_share,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 24,
                ),
              ),
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
                        widget.lodgetosend.lodgeName,
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
                        widget.lodgetosend.lodgeAddress,
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
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey[400]!.withOpacity(0.4),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "#${widget.lodgetosend.lodgeArea}",
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
                        widget.lodgetosend.lodgeBusinessHours,
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
                        widget.lodgetosend.lodgePhoneNumber,
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
                      padding: const EdgeInsets.only(left: 8.0),
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
                        widget.lodgetosend.lodgePriceType1,
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
                    widget.lodgetosend.lodgeSubtitle,
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
                          widget.lodgetosend.lodgeUrl2,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                //음식 설명
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(widget.lodgetosend.lodgeName),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PlaceInfo extends StatefulWidget {
  final PlaceToSend placetosend;
  PlaceInfo({Key? key, required this.placetosend}) : super(key: key);

  @override
  State<PlaceInfo> createState() => _PlaceInfoState();
}

class _PlaceInfoState extends State<PlaceInfo> {
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
                //appabar 배경 이미지
                image: DecorationImage(
                    image: NetworkImage(widget.placetosend.placeUrl1),
                    fit: BoxFit.cover,
                    //이미지 어두운 필터 씌우기
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken)),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.ios_share,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 24,
                ),
              ),
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
                        widget.placetosend.placeName,
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
                        widget.placetosend.placeAddress,
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
                                "#${widget.placetosend.placeClassifiaction}",
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
                        widget.placetosend.placeBusinessHours,
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
                        widget.placetosend.placePhoneNumber,
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
                        widget.placetosend.placePrice,
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
                    widget.placetosend.placeSubtitle,
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
                          widget.placetosend.placeUrl2,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                //음식 설명
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(widget.placetosend.placeName),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
