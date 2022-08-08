import 'package:chang_2nd_main_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/favorite_service.dart';
import 'favorite_list.dart';
import 'package:chang_2nd_main_project/services/firebase_analytics.dart';

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
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;

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
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 100,
                elevation: 0,
                bottomOpacity: 0.0,
                title: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${user.displayName} 님이",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "     찜한 곳들이에요",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                //favorite 리스트 확인 이벤트 발생
                                firebaseScreenViewChanged(
                                    user.uid, "FavoriteList()");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FavoriteList()),
                                );
                              },
                              child: Text(
                                "제주도    >",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              '총 '
                              '${_postFoodList.length + _postLodgeList.length + _postPlaceList.length}'
                              '곳',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                      child: GestureDetector(
                        onTap: () {
                          //favorite 리스트 확인 이벤트 발생
                          firebaseScreenViewChanged(user.uid, "FavoriteList()");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoriteList()),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://api.cdn.visitjeju.net/photomng/imgpath/202110/28/11c3035e-03f9-4b41-9a9d-d21abc399ee0.jpg'),
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      });
    });
  }
}
