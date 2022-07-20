import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

/// 홈페이지
class PlaceInfo extends StatefulWidget {
  const PlaceInfo({Key? key}) : super(key: key);

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
      builder: (context, bucketService, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assetName"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            leading: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 24,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.ios_share,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(150),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("음식점 이름"),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.place_outlined,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text("주소"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 8, 10),
                            height: 32,
                            width: 66,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xffd9d9d9),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "# 1인분 주문 가능",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 8, 10),
                            height: 32,
                            width: 66,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xffd9d9d9),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "제주도",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Row(
                    children: [
                      SizedBox(
                        height: 25,
                        width: 70,
                        child: Text(
                          "오픈시간",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                        width: 200,
                        child: Text(
                          "매일 10:00 ~ 21:00",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 25,
                        width: 70,
                        child: Text(
                          "오픈시간",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                        width: 200,
                        child: Text(
                          "매일 10:00 ~ 21:00",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 25,
                        width: 70,
                        child: Text(
                          "오픈시간",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                        width: 200,
                        child: Text(
                          "매일 10:00 ~ 21:00",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15.0),
                    child: Text(
                      "음식점 한 줄 소개",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    width: 339,
                    height: 219,
                    child: Image.network(
                      "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text("1"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
