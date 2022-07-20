import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

/// 홈페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            title: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "어디로 여행가시나요?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0, right: 10),
                child: TextButton(
                  child: Text(
                    "로그아웃",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    // 로그아웃
                    context.read<AuthService>().signOut();

                    // 로그인 페이지로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// Textfield
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 4.0, bottom: 4.0),
                    child: TextField(
                      //controller 삽입 필요
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffd9d9d9),
                        hintText: "ex.김녕 바당길(바닷길)",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),

                        /// 돋보기 아이콘
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // 돋보기 아이콘 클릭
                          },
                        ),
                      ),
                      onSubmitted: (v) {
                        // 엔터를 누르는 경우
                      },
                    ),
                  ),

                  /// 요즘 인기있는 여행지
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 16,
                      bottom: 10,
                    ),
                    child: Text(
                      "요즘 인기있는 여행지",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  /// 여행지 아이콘
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(18, 4, 8, 10),
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    /// 추천 키워드
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 12, right: 5),
                      child: Text(
                        "혼밥하기 좋은 식당",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.chevron_right,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),

                /// 여행지 리스트
                Container(
                  padding: EdgeInsets.only(top: 8, left: 16),
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 10),
                          height: 200,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0xffd9d9d9),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.network(
                                "https://i.ibb.co/CwzHq4z/trans-logo-512.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RecommendList extends StatefulWidget {
  RecommendList({Key? key}) : super(key: key);

  @override
  State<RecommendList> createState() => _RecommendListState();
}

class _RecommendListState extends State<RecommendList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                /// 추천 키워드
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12, right: 5),
                  child: Text(
                    "혼밥하기 좋은 식당",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.chevron_right,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(top: 8, left: 16),
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 10),
                          height: 200,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0xffd9d9d9),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.network(
                                "https://i.ibb.co/CwzHq4z/trans-logo-512.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
