import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

/// 홈페이지
class PlaceList extends StatefulWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return Consumer(
      builder: (context, bucketService, child) {
        return Scaffold(
          body: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                centerTitle: false,
                bottom: PreferredSize(
                  preferredSize: const Size(double.infinity, kToolbarHeight),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      right: 18.0,
                    ),
                    child: const TabBar(
                      labelColor: Colors.black,
                      indicatorColor: Colors.black,
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 2.0),
                          insets: EdgeInsets.only(left: 1, right: 1)),
                      tabs: [
                        Tab(
                            child: Text(
                          "맛집",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )),
                        Tab(
                            child: Text(
                          "숙소",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )),
                        Tab(
                            child: Text(
                          "관광지",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                title: const Text(
                  "애월",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              body: const TabBarView(
                children: [
                  Dining(),
                  Dining(),
                  Dining(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// 맛집 Body
class Dining extends StatefulWidget {
  const Dining({Key? key}) : super(key: key);

  @override
  State<Dining> createState() => _DiningState();
}

class _DiningState extends State<Dining> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Row(
            children: [
              Text("키워드"),
              Text("키워드"),
              Text("키워드"),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey,
                          ),
                          width: double.maxFinite,
                          height: 200,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 28,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text("맛집 이름"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text("음식점 장소"),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
