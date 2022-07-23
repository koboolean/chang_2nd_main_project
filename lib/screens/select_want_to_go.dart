import 'package:chang_2nd_main_project/services/schedule_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'add_schedule.dart';
// import 'favorite_list.dart';
// import 'home.dart';
import 'schedule_complete.dart';

class SelectWantToGo extends StatefulWidget {
  const SelectWantToGo({Key? key}) : super(key: key);

  @override
  State<SelectWantToGo> createState() => _SelectWantToGoState();
}

class _SelectWantToGoState extends State<SelectWantToGo> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleService>(
        builder: (context, scheduleService, child) {
          var foodTab = scheduleService.foodTabList;
          var hotelTab = scheduleService.hotelTabList;
          var touristTab = scheduleService.touristTabList;
          return DefaultTabController(
            initialIndex: 0,
            length: 3,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
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
                    preferredSize: Size.fromHeight(130),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '가고 싶은 곳을 선택해주세요',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '여행지 간의 최단 경로를 계산해 일정을 만들어줍니다',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          TabBar(
                            labelColor: Colors.black,
                            tabs: [
                              Tab(
                                text: '맛집',
                              ),
                              Tab(
                                text: '숙소',
                              ),
                              Tab(
                                text: '관광지',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 18, top: 10, right: 18),
                      child: TabBarView(
                        children: [
                          scheduleService.listViewBuild(foodTab),
                          scheduleService.listViewBuild(hotelTab),
                          scheduleService.listViewBuild(touristTab),
                        ],
                      ),
                    ),
                    // Positioned(
                    //   top: MediaQuery.of(context).size.height - 630,
                    //   //left: MediaQuery.of(context).size.width - 300,
                    //   child: Expanded(
                    //     child: Container(
                    //       decoration: BoxDecoration(color: Colors.white),
                    //       child: Row(
                    //         children: [
                    //           SizedBox(
                    //             width: 50,
                    //           ),

                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height - 620,
                      left: 0,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleComplete(),
                            ),
                          );
                        },
                        child: Text('확인'), //font 적용하기
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          minimumSize: Size(339, 48),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}