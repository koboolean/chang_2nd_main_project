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
      // var hotelTab = scheduleService.hotelTabList;
      // var touristTab = scheduleService.touristTabList;
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
              body: Container(
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 18, top: 15, right: 18),
                child: TabBarView(
                  children: [
                    Scaffold(
                      appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leadingWidth: 0,
                          title: Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  backgroundColor:
                                      Color.fromRGBO(229, 229, 229, 1),
                                  minimumSize: Size(63, 32),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: Text('전체'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  backgroundColor:
                                      Color.fromRGBO(229, 229, 229, 1),
                                  minimumSize: Size(63, 32),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: Text('1인 주문가능'),
                              )
                            ],
                          )
                          //  ListView.builder(
                          //   shrinkWrap: true,
                          //   scrollDirection: Axis.horizontal,
                          //   itemCount: foodTab.length,
                          //   itemBuilder: (context, index) {
                          //     return TextButton(
                          //       onPressed: () {},
                          //       style: TextButton.styleFrom(
                          //         primary: Colors.black,
                          //         backgroundColor:
                          //             Color.fromRGBO(229, 229, 229, 1),
                          //         minimumSize: Size(63, 32),
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(100),
                          //         ),
                          //       ),
                          //       child: Text('전체'),
                          //     );
                          //   },
                          // ),
                          ),
                      body: ListView.builder(
                        itemCount: foodTab.length,
                        itemBuilder: (context, index) {
                          var food = foodTab[index];
                          return ListTile(
                            leading: FlutterLogo(size: 56.0),
                            title: Row(
                              children: [
                                Text(food.name),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(food.category),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Icon(Icons.place_outlined),
                                SizedBox(
                                  width: 3.5,
                                ),
                                Text(food.address),
                              ],
                            ),
                            trailing: scheduleService.checkedList.contains(food)
                                ? Icon(Icons.check_circle,
                                    color: Color.fromRGBO(237, 140, 29, 1))
                                : Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.grey[350],
                                  ),
                            onTap: () {
                              scheduleService.toggleCheckBox(food);
                            },
                          );
                        },
                      ),
                    ),
                    Text('2'),
                    Text('3'),
                  ],
                ),
              ),
              bottomNavigationBar: SizedBox(
                height: 80,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //scheduleService.checkedList.addAll(iterable);
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
                        minimumSize: Size(300, 48),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                  ],
                ),
              )),
        ),
      );
    });
  }
}

// class KeyWordSort extends StatelessWidget {
//   const KeyWordSort({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         TextButton(
//           onPressed: () {},
//           style: TextButton.styleFrom(
//             primary: Colors.black,
//             backgroundColor: Color.fromRGBO(229, 229, 229, 1),
//             minimumSize: Size(63, 32),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(100),
//             ),
//           ),
//           child: Text('전체'),
//         ),
//       ],
//     );
//   }
// }
