//import 'package:chang_2nd_main_project/screens/place.dart';
import 'package:chang_2nd_main_project/services/auth_service.dart';
import 'package:chang_2nd_main_project/services/schedule_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List selectedCheckBox = [];
    return Consumer<ScheduleService>(
      builder: (context, scheduleService, child) {
        //var foodTab = scheduleService.foodTabList; // stream bulider firabase로 대처
        // var hotelTab = scheduleService.hotelTabList;
        // var touristTab = scheduleService.touristTabList;
        return DefaultTabController(
          initialIndex: 0,
          length: 2,
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
                        '가고 싶은 곳을 \n 5개 이상 선택해주세요',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TabBar(
                        indicatorColor: Color.fromRGBO(221, 81, 37, 1),
                        labelColor: Color.fromRGBO(221, 81, 37, 1),
                        tabs: [
                          Tab(
                            text: '맛집',
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
              padding: EdgeInsets.only(left: 18, top: 15, right: 18),
              child: TabBarView(
                children: [
                  Scaffold(
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35,
                          width: double.infinity,
                          //   child: StreamBuilder<QuerySnapshot>(
                          //     //수정 해야함
                          //     stream: FirebaseFirestore.instance
                          //         .collection('foodNameUser')
                          //         .snapshots(),
                          //     builder: (context, snapshot) {
                          //       // final authService = context.read<AuthService>();
                          //       // final user = authService.currentUser()!;
                          //       final ItemsToFirebase = snapshot.data!.docs;
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              //           var food = ItemsToFirebase[index];
                              return Container(
                                padding: EdgeInsets.all(3),
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    primary: Colors.black,
                                    backgroundColor:
                                        Color.fromRGBO(229, 229, 229, 1),
                                    minimumSize: Size(60, 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: Text(
                                    '전체',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('foodArea')
                                .snapshots(),
                            builder: (context, foodArea) {
                              return StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('foodNameUser')
                                    .snapshots(),
                                builder: (context, foodNameUser) {
                                  var foodAreaItems = foodArea.data!.docs;
                                  var foodNameUserItems =
                                      foodNameUser.data!.docs;
                                  final authService =
                                      context.read<AuthService>();
                                  return ListView.builder(
                                    itemCount: foodNameUserItems.length,
                                    itemBuilder: (context, index) {
                                      var foodAreaObjectTypeItems =
                                          foodAreaItems.where(
                                        (element) {
                                          return (element.get('idx') ==
                                                  foodNameUserItems[index]
                                                      .get('idx')) &&
                                              (foodNameUserItems[index]
                                                      .get('userId') ==
                                                  authService
                                                      .currentUser()!
                                                      .uid);
                                        },
                                      ).toList();
                                      DisplaySelectList itemList =
                                          DisplaySelectList(
                                              name: foodAreaObjectTypeItems[0]
                                                  .get('name'),
                                              classification:
                                                  foodAreaObjectTypeItems[0]
                                                      .get('classification'),
                                              address:
                                                  foodAreaObjectTypeItems[0]
                                                      .get('address'),
                                              imageUrl:
                                                  foodAreaObjectTypeItems[0]
                                                      .get('url1'),
                                              idx: foodNameUserItems[index]
                                                  .get('idx'),
                                              selectRouteEnable:
                                                  foodNameUserItems[index].get(
                                                      'selectRouteEnable'));

                                      return ListTile(
                                        leading: SizedBox(
                                          height: 56,
                                          width: 56,
                                          child: Image.network(
                                            itemList.imageUrl,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        title: Row(
                                          children: [
                                            Text(itemList.name),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(itemList.classification),
                                          ],
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Icon(Icons.place_outlined),
                                            SizedBox(
                                              width: 3.5,
                                            ),
                                            Flexible(
                                              child: Text(
                                                itemList.address,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: //itemList.selectRouteEnable
                                            scheduleService.itemsList
                                                    .contains(itemList.idx)
                                                ? Icon(Icons.check_circle,
                                                    color: Color.fromRGBO(
                                                        237, 140, 29, 1))
                                                : Icon(
                                                    Icons.check_circle_outline,
                                                    color: Colors.grey[350],
                                                  ),
                                        onTap: () {
                                          scheduleService.toggleCheckBox(
                                              itemList.idx); // 선택된 리스트 담기
                                        },
                                      );
                                    },
                                  );
                                },
                              );

                              // var foodNameUserItems = foodNameUser
                              //     .data!.docs; // 사용자가 선택한 food
                              //var foodAreaDoc = foodAreaItems[index];
                              //var test = foodNameUserItems[index];
                              //return Text('data');
                              // if(foodAreaDoc.get('name') ==
                              //         foodAreaDoc.get('nameId')){

                              // print(foodAreaDoc.get('nameId'));
                              // return ListTile(
                              //   leading: SizedBox(
                              //     height: 56,
                              //     width: 56,
                              //     child: Image.network(
                              //       foodAreaDoc.get('url1'),
                              //       fit: BoxFit.fill,
                              //     ),
                              //   ),
                              //   title: Row(
                              //     children: [
                              //       Text(foodAreaDoc.get('name')),
                              //       SizedBox(
                              //         width: 6,
                              //       ),
                              //       Text(foodAreaDoc
                              //           .get('classification')),
                              //     ],
                              //   ),
                              //   subtitle: Row(
                              //     children: [
                              //       Wrap(
                              //         children: [
                              //           Icon(Icons.place_outlined),
                              //           SizedBox(
                              //             width: 3.5,
                              //           ),
                              //           Text(
                              //             foodAreaDoc.get('address'),
                              //             // maxLines: 2,
                              //             // overflow: TextOverflow.ellipsis,
                              //           ),
                              //         ],
                              //       )
                              //     ],
                              //   ),
                              // trailing: foodNameUserItems[index]
                              //         .get('isFavorite')
                              //     // scheduleService.checkedList
                              //     //         .contains(food)
                              //     ? Icon(Icons.check_circle,
                              //         color: Color.fromRGBO(
                              //             237, 140, 29, 1))
                              //     : Icon(
                              //         Icons.check_circle_outline,
                              //         color: Colors.grey[350],
                              //       ),
                              //  onTap: () {
                              //scheduleService.toggleCheckBox(food);
                              //  },

                              //   ),
                              //   title: Row(
                              //     children: [
                              //       Text(foodAreaDoc.get('name')),
                              //       SizedBox(
                              //         width: 6,
                              //       ),
                              //       Text(foodAreaDoc.get('category')),
                              //     ],
                              //   ),
                              //   //
                              //   //
                              //);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('2'),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScheduleComplete(
                            daysTabBar: 3, // 2박 3일 더미데이터
                          ),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
