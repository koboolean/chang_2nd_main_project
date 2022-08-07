import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/screens/place_list.dart';
import 'package:chang_2nd_main_project/services/auth_service.dart';
import 'package:chang_2nd_main_project/services/favorite_service.dart';
import 'package:chang_2nd_main_project/services/travel_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'favorite_city.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  State<FavoriteList> createState() => _FavoriteListPageState();
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
                          indicatorColor: Colors.amber[800],
                          labelColor: Colors.amber[800],
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
                              (_postFoodList.isEmpty)
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
                                                  color: Colors.amber[800],
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
                                                  const EdgeInsets.all(15.0),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '총 ${_postFoodList.length}곳',
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
                                                itemCount: _postFoodList.length,
                                                itemBuilder: (context, index) {
                                                  final doc =
                                                      _postFoodList[index];
                                                  String name = doc['name'];
                                                  String url = doc['url1'];
                                                  String address =
                                                      doc['address'];
                                                  String classification =
                                                      doc['classification'];

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //       builder: (context) =>
                                                        //           PlaceInfo(
                                                        //             sendName: ('소랑드르'),
                                                        //           )),
                                                        // );
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
                                                                    url,
                                                                    fit: BoxFit
                                                                        .fill,
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
                                                                          name,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          address,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                Colors.grey[600],
                                                                                overflow: TextOverflow.ellipsis
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          classification,
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
                                                  color: Colors.amber[800],
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
                                                  const EdgeInsets.all(15.0),
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
                                                  String name = doc['name'];
                                                  String url = doc['url1'];
                                                  String address =
                                                      doc['address'];

                                                  print(_postLodgeList);

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //       builder: (context) =>
                                                        //           PlaceInfo(
                                                        //             sendName: ('소랑드르'),
                                                        //           )),
                                                        // );
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
                                                                    url,
                                                                    fit: BoxFit
                                                                        .fill,
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
                                                                          name,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          address,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                Colors.grey[600],
                                                                                  overflow: TextOverflow.ellipsis
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
                                                  color: Colors.amber[800],
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
                                                  const EdgeInsets.all(15.0),
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
                                                  String name = doc['name'];
                                                  String url = doc['url1'];
                                                  String address =
                                                      doc['address'];

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //       builder: (context) =>
                                                        //           PlaceInfo(
                                                        //             sendName: ('소랑드르'),
                                                        //           )),
                                                        // );
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
                                                                    url,
                                                                    fit: BoxFit
                                                                        .fill,
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
                                                                          name,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          address,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                Colors.grey[600],
                                                                                  overflow: TextOverflow.ellipsis
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
