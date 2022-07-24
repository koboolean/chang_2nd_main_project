import 'package:chang_2nd_main_project/models/food.dart';
import 'package:chang_2nd_main_project/services/trip_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorite_list.dart';

/// 홈 페이지
/// 홈페이지
class FavoriteCity extends StatefulWidget {
  const FavoriteCity({Key? key}) : super(key: key);

  @override
  State<FavoriteCity> createState() => _FavoriteCityPageState();
}

class _FavoriteCityPageState extends State<FavoriteCity> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TripService>(
      builder: (context, tripService, child) {
        List<Food> foodList = tripService.foodList;
        return Scaffold(
            appBar: AppBar(
              title: Text("사용자님이 찜한 곳들이에요"),
              backgroundColor: Colors.amber,
            ),
            body: Column(
              children: [
                Divider(height: 10),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoriteList()),
                          );
                        },
                        child: Text("제주도 >"),
                      ),
                      Spacer(),
                      Text("15곳"),
                    ],
                  ),
                ),
                Divider(height: 10),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(Icons.face),
                        SizedBox(height: 10),
                        Text("제주도에서 아직 찜한 곳이 없어요"),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {}, //제주도 구경하기 클릭시 이동
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
                                "제주도 구경하기",
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
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoriteList()),
                          );
                        },
                        child: Text("부산 >"),
                      ),
                      Spacer(),
                      Text("15곳"),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 140,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://i.ibb.co/xf2HpfG/dynamite.jpg',
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
                          Text('Dynamite',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text('BTS')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://i.ibb.co/xf2HpfG/dynamite.jpg',
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
                          Text('Dynamite',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text('BTS')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://i.ibb.co/xf2HpfG/dynamite.jpg',
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
                          Text('Dynamite',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text('BTS')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://i.ibb.co/xf2HpfG/dynamite.jpg',
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
                          Text('Dynamite',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text('BTS')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: '찜한곳'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.flight_takeoff_outlined), label: '여행계획'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: 'MY'),
              ],
            ));
      },
    );
  }
}
