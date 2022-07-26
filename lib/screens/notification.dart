import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:chang_2nd_main_project/screens/main_page.dart';
import 'package:chang_2nd_main_project/screens/place.dart';
import 'package:chang_2nd_main_project/screens/place_list.dart';

import 'package:chang_2nd_main_project/services/auth_service.dart';
import 'package:chang_2nd_main_project/services/schedule_service.dart';
import 'package:chang_2nd_main_project/services/trip_service.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: false,
        title: Text(
          "알림",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: InkWell(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlaceList()),
                );
              },
              child: Container(
                height: 108,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 19.5, bottom: 4),
                        child: Text(
                          "혼자 여행 가고 싶은 사람?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Text(
                          "첫 혼행으로 애월 어때요? 1인분 주문가능한 식당도 알려줄게요.",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Text(
                        "2022.08.13",
                        style: TextStyle(
                          color: Colors.grey[500]!,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
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
    );
  }
}
