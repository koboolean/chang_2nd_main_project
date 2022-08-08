import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/services/favorite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  State<FavoriteList> createState() => _FavoriteListPageState();
}

//place_info에 송부할 foodList 데이터 생성
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

//place_info에 송부할 foodList 데이터 생성
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

//place_info에 송부할 foodList 데이터 생성
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

class _FavoriteListPageState extends State<FavoriteList> {
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
    return Consumer<FavoriteFoodService>(
        builder: (context, favoriteFoodService, child) {
      return Consumer<FavoriteLodgeService>(
          builder: (context, favoriteLodgeService, child) {
        return Consumer<FavoritePlaceService>(
          builder: (context, favoritePlaceService, child) {
            List<Map<String, dynamic>> _postFoodList =
                favoriteFoodService.postFoodList;
            List<Map<String, dynamic>> _postLodgeList =
                favoriteLodgeService.postLodgeList;
            List<Map<String, dynamic>> _postPlaceList =
                favoritePlaceService.postPlaceList;
            return DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: false,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    titleSpacing: 0.0,
                    title: Text(
                      "제주도",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  body: SafeArea(
                    child: Column(
                      children: [
                        /*Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: DropdownButton(
                              value: _selectedValue,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              underline: Container(),
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
                        ),*/
                        TabBar(
                          tabs: [
                            Tab(text: '맛집'),
                            Tab(text: "숙소"),
                            Tab(text: "관광지"),
                          ],
                          indicatorColor: Color.fromRGBO(221, 81, 37, 1),
                          labelColor: Color.fromRGBO(221, 81, 37, 1),
                          indicatorWeight: 3,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              //favoriteFoodList 확인
                              (_postFoodList.length < 1)
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: SvgPicture.asset(
                                                'assets/images/sad.svg',
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "아직 찜한 맛집이 없어요",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          GestureDetector(
                                            onTap: () {}, //제주도 숙소 클릭시 이동
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      221, 81, 37, 1),
                                                  border: Border.all(
                                                    color: Colors.transparent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  )),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "제주도 맛집 구경하기",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 100),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            /*Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 28,
                                                      width: 47,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 1,
                                                            color: Colors
                                                                .grey[500]!,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          color: Colors.white),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "전체",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 28,
                                                      width: 47,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 1,
                                                            color: Colors
                                                                .grey[500]!,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          color: Colors.white),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "한식",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 28,
                                                      width: 47,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 1,
                                                            color: Colors
                                                                .grey[500]!,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          color: Colors.white),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "양식",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),*/
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '총 ${_postFoodList.length}곳',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio:
                                                            1 / 1.74),
                                                itemCount: _postFoodList.length,
                                                itemBuilder: (context, index) {
                                                  final doc =
                                                      _postFoodList[index];

                                                  //Firestore 인덱스 가져오기
                                                  String foodSubtitle =
                                                      doc['Subtitle'];
                                                  String foodAddress =
                                                      doc['address'];
                                                  String foodBusinessHours =
                                                      doc['businessHours'];
                                                  String foodClassification =
                                                      doc['classification'];
                                                  String foodField14 =
                                                      doc['field14'];
                                                  String foodIdx = doc['idx'];
                                                  String foodNaverLink =
                                                      doc['naverlink'];
                                                  String foodNote = doc['note'];
                                                  String foodPhonenumber =
                                                      doc['phoneNumber'];
                                                  String foodPrice =
                                                      doc['price'];
                                                  String foodServingSize =
                                                      doc['servingSize'];
                                                  String foodName = doc['name'];
                                                  String foodUrl1 = doc['url1'];
                                                  String foodUrl2 = doc['url2'];
                                                  String foodArea = doc['area'];

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

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      FoodInfo(
                                                                        foodtoreceive:
                                                                            foodtosend,
                                                                      )),
                                                        );
                                                      },
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(8),
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .transparent,
                                                              // blurRadius: 1,
                                                              // spreadRadius: 1,
                                                            )
                                                          ],
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              8)),
                                                              child: Stack(
                                                                children: [
                                                                  Image.network(
                                                                    foodUrl1,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 220,
                                                                    width: 163,
                                                                  ),
                                                                  Positioned(
                                                                    top: 10,
                                                                    right: 10,
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // setState(() => isPressed = !isPressed);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .grey[700]!
                                                                              .withOpacity(0.2),
                                                                          borderRadius:
                                                                              BorderRadius.circular(100),
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
                                                                          Icons
                                                                              .favorite_border,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              24,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        6.0),
                                                                child: Stack(
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          foodName,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              2,
                                                                        ),
                                                                        Text(
                                                                          foodAddress,
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.normal,
                                                                              color: Colors.grey[600],
                                                                              overflow: TextOverflow.ellipsis),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              2,
                                                                        ),
                                                                        Text(
                                                                          foodClassification,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                Colors.grey[600],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              //favoriteLodgeList 확인
                              (_postLodgeList.length < 1)
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: SvgPicture.asset(
                                                'assets/images/sad.svg',
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "아직 찜한 숙소가 없어요",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          GestureDetector(
                                            onTap: () {}, //제주도 숙소 클릭시 이동
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      221, 81, 37, 1),
                                                  border: Border.all(
                                                    color: Colors.transparent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  )),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "제주도 숙소 구경하기",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 100),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            /*Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 28,
                                                      width: 47,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 1,
                                                            color: Colors
                                                                .grey[500]!,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          color: Colors.white),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "전체",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 28,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 1,
                                                            color: Colors
                                                                .grey[500]!,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          color: Colors.white),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "게스트하우스",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  // GestureDetector(
                                                  //   onTap: () {},
                                                  //   child: Container(
                                                  //     height: 28,
                                                  //     width: 47,
                                                  //     decoration: BoxDecoration(
                                                  //         border: Border.all(
                                                  //           width: 1,
                                                  //           color:
                                                  //               Colors.grey[500]!,
                                                  //         ),
                                                  //         borderRadius:
                                                  //             BorderRadius
                                                  //                 .circular(16),
                                                  //         color: Colors.white),
                                                  //     child: Align(
                                                  //       alignment:
                                                  //           Alignment.center,
                                                  //       child: Text(
                                                  //         "양식",
                                                  //         style: TextStyle(
                                                  //           fontWeight:
                                                  //               FontWeight.w500,
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),*/
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '총 ${_postLodgeList.length}곳',
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio:
                                                            1 / 1.74),
                                                itemCount:
                                                    _postLodgeList.length,
                                                itemBuilder: (context, index) {
                                                  final doc =
                                                      _postLodgeList[index];

                                                  String lodgeBreakFastYn =
                                                      doc['BreakfastYn'];
                                                  String lodgeSubtitle =
                                                      doc['Subtitle'];
                                                  String lodgeAddress =
                                                      doc['address'];
                                                  String lodgeArea =
                                                      doc['area'];
                                                  String lodgeBusinessHours =
                                                      doc['businessHours'];
                                                  String lodgeIdx = doc['idx'];
                                                  String lodgeName =
                                                      doc['name'];
                                                  String lodgeNaverLink =
                                                      doc['naverlink'];
                                                  String lodgePartyYn =
                                                      doc['partyYn'];
                                                  String lodgePhoneNumber =
                                                      doc['phoneNumber'];
                                                  String lodgePriceType1 =
                                                      doc['priceType1'];
                                                  String lodgePriceType2 =
                                                      doc['priceType2'];
                                                  String lodgePriceType3 =
                                                      doc['priceType3'];
                                                  String lodgeToiletYn =
                                                      doc['toiletYn'];
                                                  String lodgeUrl1 =
                                                      doc['url1'];
                                                  String lodgeUrl2 =
                                                      doc['url2'];

                                                  final lodgetosend =
                                                      LodgeToSend(
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      LodgeInfo(
                                                                        lodgetoreceive:
                                                                            lodgetosend,
                                                                      )),
                                                        );
                                                      },
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(8),
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .transparent,
                                                              // blurRadius: 1,
                                                              // spreadRadius: 1,
                                                            )
                                                          ],
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              8)),
                                                              child: Stack(
                                                                children: [
                                                                  Image.network(
                                                                    lodgeUrl1,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 220,
                                                                    width: 163,
                                                                  ),
                                                                  Positioned(
                                                                    top: 10,
                                                                    right: 10,
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // setState(() => isPressed = !isPressed);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .grey[700]!
                                                                              .withOpacity(0.2),
                                                                          borderRadius:
                                                                              BorderRadius.circular(100),
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
                                                                          Icons
                                                                              .favorite_border,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              24,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        6.0),
                                                                child: Stack(
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          lodgeName,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              2,
                                                                        ),
                                                                        Text(
                                                                          lodgeAddress,
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.normal,
                                                                              color: Colors.grey[600],
                                                                              overflow: TextOverflow.ellipsis),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              //favoritePlaceList 확인
                              (_postPlaceList.length < 1)
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: SvgPicture.asset(
                                                'assets/images/sad.svg',
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "아직 찜한 관광지가 없어요",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          GestureDetector(
                                            onTap: () {}, //제주도 관광지 클릭시 이동
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      221, 81, 37, 1),
                                                  border: Border.all(
                                                    color: Colors.transparent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  )),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "제주도 관광지 구경하기",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 100),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            /*Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 28,
                                                      width: 47,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 1,
                                                            color: Colors
                                                                .grey[500]!,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          color: Colors.white),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "전체",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: 8,
                                                  // ),
                                                  // GestureDetector(
                                                  //   onTap: () {},
                                                  //   child: Container(
                                                  //     height: 28,
                                                  //     width: 47,
                                                  //     decoration: BoxDecoration(
                                                  //         border: Border.all(
                                                  //           width: 1,
                                                  //           color:
                                                  //               Colors.grey[500]!,
                                                  //         ),
                                                  //         borderRadius:
                                                  //             BorderRadius
                                                  //                 .circular(16),
                                                  //         color: Colors.white),
                                                  //     child: Align(
                                                  //       alignment:
                                                  //           Alignment.center,
                                                  //       child: Text(
                                                  //         "한식",
                                                  //         style: TextStyle(
                                                  //           fontWeight:
                                                  //               FontWeight.w500,
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // SizedBox(
                                                  //   width: 8,
                                                  // ),
                                                  // GestureDetector(
                                                  //   onTap: () {},
                                                  //   child: Container(
                                                  //     height: 28,
                                                  //     width: 47,
                                                  //     decoration: BoxDecoration(
                                                  //         border: Border.all(
                                                  //           width: 1,
                                                  //           color:
                                                  //               Colors.grey[500]!,
                                                  //         ),
                                                  //         borderRadius:
                                                  //             BorderRadius
                                                  //                 .circular(16),
                                                  //         color: Colors.white),
                                                  //     child: Align(
                                                  //       alignment:
                                                  //           Alignment.center,
                                                  //       child: Text(
                                                  //         "양식",
                                                  //         style: TextStyle(
                                                  //           fontWeight:
                                                  //               FontWeight.w500,
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),*/
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '총 ${_postPlaceList.length}곳',
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio:
                                                            1 / 1.74),
                                                itemCount:
                                                    _postPlaceList.length,
                                                itemBuilder: (context, index) {
                                                  final doc =
                                                      _postPlaceList[index];

                                                  //Place data 호출
                                                  String placeAddress =
                                                      doc['address'];
                                                  String placeArea =
                                                      doc['area'];
                                                  String placeBusinessHours =
                                                      doc['businessHours'];
                                                  String placeClassifiaction =
                                                      doc['classification'];
                                                  String placeField13 =
                                                      doc['field13'];
                                                  String placeIdx = doc['idx'];
                                                  String placeName =
                                                      doc['name'];
                                                  String placeNaverLink =
                                                      doc['naverlink'];
                                                  String placeNote =
                                                      doc['note'];
                                                  String placePhoneNumber =
                                                      doc['phoneNumber'];
                                                  String placePrice =
                                                      doc['price'];
                                                  String placeSubtitle =
                                                      doc['subTitle'];
                                                  String placeUrl1 =
                                                      doc['url1'];
                                                  String placeUrl2 =
                                                      doc['url2'];

                                                  final placetosend =
                                                      PlaceToSend(
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      PlaceInfo(
                                                                        placetoreceive:
                                                                            placetosend,
                                                                      )),
                                                        );
                                                      },
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(8),
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .transparent,
                                                              // blurRadius: 1,
                                                              // spreadRadius: 1,
                                                            )
                                                          ],
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              8)),
                                                              child: Stack(
                                                                children: [
                                                                  Image.network(
                                                                    placeUrl1,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 220,
                                                                    width: 163,
                                                                  ),
                                                                  Positioned(
                                                                    top: 10,
                                                                    right: 10,
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // setState(() => isPressed = !isPressed);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .grey[700]!
                                                                              .withOpacity(0.2),
                                                                          borderRadius:
                                                                              BorderRadius.circular(100),
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
                                                                          Icons
                                                                              .favorite_border,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              24,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        6.0),
                                                                child: Stack(
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          placeName,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              2,
                                                                        ),
                                                                        Text(
                                                                          placeAddress,
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.normal,
                                                                              color: Colors.grey[600],
                                                                              overflow: TextOverflow.ellipsis),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
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
                  ),
                ));
          },
        );
      });
    });
  }
}
