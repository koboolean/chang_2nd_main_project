import 'dart:ui';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class ScheduleComplete extends StatelessWidget {
  const ScheduleComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: Image.asset("assets/images/notebook.png"),
              ),
            ],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(331), //431
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '제주도',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('3박 4일')
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Colors.grey,
                              minimumSize: Size(63, 32),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            icon: Icon(Icons.add),
                            label: Text('숙소'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 211,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Center(
                        child: Text('지도'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: TabBar(
                        labelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: '1일차',
                          ),
                          Tab(
                            text: '2일차',
                          ),
                          Tab(
                            text: '3일차',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            //height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 18, top: 10, right: 18),
            child: TabBarView(
              children: [
                DisplayScheduleList(
                    name: '1일차 장소',
                    catagory: '카페',
                    address: '위치',
                    moveTime: 10),
                DisplayScheduleList(
                    name: '2일차 장소',
                    catagory: '카페',
                    address: '주소',
                    moveTime: 20),
                DisplayScheduleList(
                    name: '3일차 장소',
                    catagory: '카페',
                    address: '주소',
                    moveTime: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DisplayScheduleList extends StatelessWidget {
  const DisplayScheduleList(
      {Key? key,
        required this.name,
        required this.catagory,
        required this.address,
        required this.moveTime})
      : super(key: key);

  final String name;
  final String catagory;
  final String address;
  final int moveTime;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: FlutterLogo(size: 56.0),
          title: Row(
            children: [
              Text('장소'),
              SizedBox(
                width: 6,
              ),
              Text('숙박'),
            ],
          ),
          subtitle: Row(
            children: [
              Icon(Icons.place_outlined),
              SizedBox(
                width: 3.5,
              ),
              Text('위치'),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
            ),
            DottedLine(
              direction: Axis.vertical,
              lineLength: 40,
              lineThickness: 2,
              dashColor: Colors.black,
              dashGapLength: 4,
            ),
            SizedBox(
              width: 40,
            ),
            Text('차로 $moveTime 분 소요'),
            Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.grey,
                minimumSize: Size(63, 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text('길안내'),
            ),
          ],
        );
      },
    );
  }
}