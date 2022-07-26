import 'package:chang_2nd_main_project/services/travel_service.dart';
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
    return Consumer<TravelService>(
      builder: (context, travelService, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "사용자님이 찜한 곳들이에요",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Divider(height: 10),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.all(10),
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
                Container(
                  width: double.infinity,
                  height: 200,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://api.cdn.visitjeju.net/photomng/imgpath/202110/28/11c3035e-03f9-4b41-9a9d-d21abc399ee0.jpg'),
                        fit: BoxFit.fill,
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
