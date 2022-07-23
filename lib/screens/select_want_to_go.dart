import 'package:chang_2nd_main_project/services/schedule_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'schedule_complete.dart';

class SelectWantToGo extends StatelessWidget {
  const SelectWantToGo({super.key});

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
                preferredSize: Size.fromHeight(150),
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
                //           TextButton(
                //             onPressed: () {},
                //             style: TextButton.styleFrom(
                //               padding: EdgeInsets.symmetric(vertical: 10),
                //               primary: Colors.black,
                //               backgroundColor: Colors.grey,
                //               minimumSize: Size(43, 22),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(100),
                //               ),
                //               textStyle: TextStyle(fontSize: 11),
                //             ),
                //             child: Text('전체'),
                //           ),
                //           TextButton(
                //             onPressed: () {},
                //             style: TextButton.styleFrom(
                //               padding: EdgeInsets.symmetric(vertical: 10),
                //               primary: Colors.black,
                //               backgroundColor: Colors.grey,
                //               minimumSize: Size(43, 22),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(100),
                //               ),
                //               textStyle: TextStyle(fontSize: 11),
                //             ),
                //             child: Text('1인분 주문가능 식당'),
                //           ),
                //           TextButton(
                //             onPressed: () {},
                //             style: TextButton.styleFrom(
                //               padding: EdgeInsets.symmetric(vertical: 10),
                //               primary: Colors.black,
                //               backgroundColor: Colors.grey,
                //               minimumSize: Size(43, 22),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(100),
                //               ),
                //               textStyle: TextStyle(fontSize: 11),
                //             ),
                //             child: Text('카페'),
                //           ),
                //           TextButton(
                //             onPressed: () {},
                //             style: TextButton.styleFrom(
                //               padding: EdgeInsets.symmetric(vertical: 10),
                //               primary: Colors.black,
                //               backgroundColor: Colors.grey,
                //               minimumSize: Size(43, 22),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(100),
                //               ),
                //               textStyle: TextStyle(fontSize: 11),
                //             ),
                //             child: Text('식당'),
                //           )
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
            // bottomNavigationBar: BottomNavigationBar(
            //   type: BottomNavigationBarType.fixed,
            //   items: [
            //     BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            //     BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '찜한곳'),
            //     BottomNavigationBarItem(
            //         icon: Icon(Icons.flight_takeoff_outlined), label: '여행계획'),
            //     BottomNavigationBarItem(
            //         icon: Icon(Icons.account_circle), label: 'MY'),
            //   ],
            // ),
          ),
        ),
      );
    });
  }
}
