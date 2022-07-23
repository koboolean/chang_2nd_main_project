import 'package:chang_2nd_main_project/models/food.dart';
import 'package:chang_2nd_main_project/services/trip_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorite_city.dart';

class FavoritePage_Room extends StatelessWidget {
  const FavoritePage_Room({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TripService>(
      builder: (context, tripService, child) {
        List<Food> foodList = tripService.foodList;
        return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text("제주도"),
                backgroundColor: Colors.amber,
                bottom: TabBar(
                  tabs: [
                    Tab(text: '맛집'),
                    Tab(text: "숙소"),
                    Tab(text: "관광지"),
                  ],
                  indicatorColor: Colors.blue[400],
                  labelColor: Colors.black,
                ),
              ),
              body: TabBarView(
                children: [
                  foodList.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(Icons.face),
                                SizedBox(height: 10),
                                Text("아직 찜한 맛집이 없어요"),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {}, //제주도 맛집 클릭시 이동
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "제주도 맛집 구경하기",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: Column(
                            children: [
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
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          left: index % 2 == 1 ? 8 : 0,
                                          right: index % 2 == 0 ? 8 : 0,
                                          top: 8,
                                          bottom: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 1,
                                              spreadRadius: 1,
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Image.network(
                                                    Food.url,
                                                    fit: BoxFit.fitHeight,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                  ),
                                                  Positioned(
                                                    top: 10,
                                                    right: 10,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        // setState(() => isPressed = !isPressed);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                        child:
                                                            // (isPressed) ? Icon(
                                                            //   Icons.favorite_border,
                                                            //   color: Colors.white,
                                                            //   size: 24,
                                                            // ),
                                                            // :
                                                            //       Icon(
                                                            //   Icons.favorite,
                                                            //   color: Colors.red,
                                                            //   size: 24,
                                                            // ),
                                                            Icon(
                                                          Icons.favorite_border,
                                                          color: Colors.white,
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
                                                    const EdgeInsets.all(6.0),
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          Food.name,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          Food.address,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors
                                                                .grey[600],
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
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                  Center(
                    child: Text("숙소"),
                  ),
                  Center(
                    child: Text("관광지"),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
