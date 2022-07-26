import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/screens/place_list.dart';
import 'package:chang_2nd_main_project/services/auth_service.dart';
import 'package:chang_2nd_main_project/services/trip_service.dart';
import 'package:flutter/material.dart';
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
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return Consumer<TripService>(
      builder: (context, tripService, child) {
        List<Food> foodList = tripService.foodList;
        return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.chevron_left, color: Colors.black),
                        Text("제주도", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                backgroundColor: Colors.yellow[60],
              ),
              body: Column(
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
                  TabBar(
                    tabs: [
                      Tab(text: '맛집'),
                      Tab(text: "숙소"),
                      Tab(text: "관광지"),
                    ],
                    indicatorColor: Colors.amber[800],
                    labelColor: Colors.amber[800],
                    unselectedLabelColor: Colors.black,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        foodList.isEmpty
                            ? Text("아직 찜한 맛집이 없어요") // 숙소 탭에서 가져오기
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    12, 12, 0, 0),
                                                height: 32,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: Color(0xffd9d9d9),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
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
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    12, 12, 0, 0),
                                                height: 32,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: Color(0xffd9d9d9),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "1인분 주문가능 식당",
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
                                      ),
                                      Expanded(
                                        child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 3 / 4),
                                          itemCount: foodList.length,
                                          itemBuilder: (context, index) {
                                            var Food = foodList[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PlaceInfo()),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    left:
                                                        index % 2 == 1 ? 8 : 0,
                                                    right:
                                                        index % 2 == 0 ? 8 : 0,
                                                    top: 8,
                                                    bottom: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        blurRadius: 1,
                                                        spreadRadius: 1,
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
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Image.network(
                                                              Food.url,
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                            ),
                                                            Positioned(
                                                              top: 10,
                                                              right: 10,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  // setState(() => isPressed = !isPressed);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 30,
                                                                  width: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey[
                                                                            700]!
                                                                        .withOpacity(
                                                                            0.2),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
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
                                                                    color: Colors
                                                                        .white,
                                                                    size: 24,
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
                                                                  .all(6.0),
                                                          child: Stack(
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    Food.name,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    Food.address,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Colors
                                                                              .grey[
                                                                          600],
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
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.sentiment_dissatisfied,
                                  color: Colors.grey, size: 35),
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
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "제주도 숙소 구경하기",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 100),
                            ],
                          ),
                        ),
                        Center(
                          child: Text("관광지"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
