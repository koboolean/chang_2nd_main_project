import 'package:chang_2nd_main_project/screens/favorite_list.dart';
import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

/// 홈페이지
class Place extends StatefulWidget {
  const Place({Key? key}) : super(key: key);

  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0, right: 10),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      "어디로 여행가시나요?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

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
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 4, 8, 10),
                      height: 32,
                      width: 66,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey[500]!,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
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
            ),
          ),
          //body
          body: RecommendList(),
        );
      },
    );
  }
}

//여행지 아이콘 함수

class TravelPlace extends StatefulWidget {
  TravelPlace({Key? key}) : super(key: key);

  @override
  State<TravelPlace> createState() => _TravelPlaceState();
}

class _TravelPlaceState extends State<TravelPlace> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 4, 8, 10),
              height: 32,
              width: 66,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white),
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
        );
      }),
    );
  }
}

//음식점 추천 리스트

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
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 18.0, bottom: 8.0),
              child: Text(
                "혼자 카페에서 여유로운 시간을",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //사진
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey,
                                //사진 삽입
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/login_background.jpeg"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              width: 133,
                              height: 180, //실제 사진 높이 = 250 - 8*5
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  // setState(() => isPressed = !isPressed);
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[700]!.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(100),
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
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 50,
                              left: 5,
                              child: Text(
                                "카페 노티드 제주",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 32,
                              child: Container(
                                  height: 20,
                                  width: 133,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 5, top: 2),
                                    child: Text(
                                      "제주시 애월읍",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[500]!,
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        );
      },
    );
  }
}
