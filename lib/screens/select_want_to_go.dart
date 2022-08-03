//import 'package:chang_2nd_main_project/screens/place.dart';
import 'package:chang_2nd_main_project/services/auth_service.dart';
import 'package:chang_2nd_main_project/services/schedule_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TabBar(
                        // indicator: BoxDecoration(shape: BoxShape.circle),
                        indicatorColor:
                            Color.fromRGBO(221, 81, 37, 1), //탭바 밑줄 색
                        labelColor: Color.fromRGBO(221, 81, 37, 1), //탭바 글자색
                        unselectedLabelColor: Color.fromRGBO(188, 188, 188, 1),

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
                  //맛집 탭 메뉴
                  Scaffold(
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
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
                                  return StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('geocode_foodArea')
                                        .snapshots(),
                                    builder: (context, geocode_foodArea) {
                                      final foodAreaItems =
                                          foodArea.data?.docs ?? [];
                                      final authService =
                                          context.read<AuthService>();
                                      final foodNameUserItems =
                                          foodNameUser.data?.docs ?? [];
                                      final authUserIdInfoodTab =
                                          foodNameUserItems.where((element) {
                                        return element.get('userId') ==
                                            authService.currentUser()!.uid;
                                      }).toList();
                                      final geocodeFoodAreaItems =
                                          geocode_foodArea.data?.docs ?? [];

                                      return ListView.builder(
                                        itemCount: authUserIdInfoodTab.length,
                                        itemBuilder: (context, index) {
                                          final foodAreaObjectTypeItems =
                                              foodAreaItems.where((element) {
                                            return (element.get('idx') ==
                                                foodNameUserItems[index]
                                                    .get('idx'));
                                            //          &&
                                            // (foodNameUserItems[index]
                                            //         .get('userId') ==
                                            //     authService
                                            //         .currentUser()!
                                            //         .uid);
                                          }).toList();

                                          final geocodeObjectTypeItems =
                                              geocodeFoodAreaItems
                                                  .where((element) {
                                            return element.get('idx') ==
                                                foodAreaObjectTypeItems[0]
                                                    .get('idx');
                                          }).toList();
                                          DisplaySelectList itemList =
                                              DisplaySelectList(
                                                  name:
                                                      foodAreaObjectTypeItems[0]
                                                          .get('name'),
                                                  classification:
                                                      foodAreaObjectTypeItems[0]
                                                          .get(
                                                              'classification'),
                                                  address:
                                                      foodAreaObjectTypeItems[0]
                                                          .get('address'),
                                                  imageUrl:
                                                      foodAreaObjectTypeItems[0]
                                                          .get('url1'),
                                                  idx: foodNameUserItems[index]
                                                      .get('idx'),
                                                  // selectRouteEnable:// 객체 생성시 디비에서가 아닌 디폴트 값으로 세팅해보기 그럼 디비 데이터 필요없을것같음
                                                  //     foodNameUserItems[index]
                                                  //         .get('selectRouteEnable'),
                                                  lat: geocodeObjectTypeItems[0]
                                                      .get('lat'),
                                                  long:
                                                      geocodeObjectTypeItems[0]
                                                          .get('long'));

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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            trailing: //itemList.selectRouteEnable
                                                scheduleService
                                                        .foodAndPlaceItemsList
                                                        .contains(itemList.idx)
                                                    ? Icon(Icons.check_circle,
                                                        color: Color.fromRGBO(
                                                            237, 140, 29, 1))
                                                    : Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color: Colors.grey[350],
                                                      ),
                                            onTap: () {
                                              scheduleService.TabToggle(
                                                  itemList.idx); // 선택된 리스트 담기
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  //관광지 탭 메뉴
                  Scaffold(
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
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
                                .collection('placeArea')
                                .snapshots(),
                            builder: (context, placeArea) {
                              return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('placeNameUser')
                                      .snapshots(),
                                  builder: (context, placeNameUser) {
                                    return StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('geocode_placeArea')
                                          .snapshots(),
                                      builder: (context, geocode_placeArea) {
                                        final placeAreaItems =
                                            placeArea.data?.docs ?? [];
                                        final placeNameUserItems =
                                            placeNameUser.data?.docs ?? [];
                                        final authService =
                                            context.read<AuthService>();
                                        final authUserIdInfoodTab =
                                            placeNameUserItems.where((element) {
                                          return element.get('userId') ==
                                              authService.currentUser()!.uid;
                                        }).toList();
                                        final geocode_placeAreaItems =
                                            geocode_placeArea.data?.docs ?? [];

                                        return ListView.builder(
                                          itemCount: placeNameUserItems.length,
                                          itemBuilder: (context, index) {
                                            var placeAreaObjectTypeItems =
                                                placeAreaItems.where(
                                              (element) {
                                                return (element.get('idx') ==
                                                        placeNameUserItems[
                                                                index]
                                                            .get('idx')) &&
                                                    (placeNameUserItems[index]
                                                            .get('userId') ==
                                                        authService
                                                            .currentUser()!
                                                            .uid);
                                              },
                                            ).toList();
                                            final geocodeObjectTypeItems =
                                                geocode_placeAreaItems
                                                    .where((element) {
                                              return element.get('idx') ==
                                                  placeAreaObjectTypeItems[0]
                                                      .get('idx');
                                            }).toList();
                                            DisplaySelectList itemList =
                                                DisplaySelectList(
                                                    name:
                                                        placeAreaObjectTypeItems[0]
                                                            .get('name'),
                                                    classification:
                                                        placeAreaObjectTypeItems[0]
                                                            .get(
                                                                'classification'),
                                                    address:
                                                        placeAreaObjectTypeItems[0]
                                                            .get('address'),
                                                    imageUrl:
                                                        placeAreaObjectTypeItems[0]
                                                            .get('url1'),
                                                    idx:
                                                        placeNameUserItems[index]
                                                            .get('idx'),
                                                    // selectRouteEnable:
                                                    //     placeNameUserItems[index].get(
                                                    //         'selectRouteEnable'),
                                                    lat:
                                                        geocodeObjectTypeItems[0]
                                                            .get('lat'),
                                                    long:
                                                        geocodeObjectTypeItems[0]
                                                            .get('long'));

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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              trailing: //itemList.selectRouteEnable
                                                  scheduleService
                                                          .foodAndPlaceItemsList
                                                          .contains(
                                                              itemList.idx)
                                                      ? Icon(Icons.check_circle,
                                                          color: Color.fromRGBO(
                                                              237, 140, 29, 1))
                                                      : Icon(
                                                          Icons
                                                              .check_circle_outline,
                                                          color:
                                                              Colors.grey[350],
                                                        ),
                                              onTap: () {
                                                scheduleService.TabToggle(
                                                    itemList.idx); // 선택된 리스트 담기
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  ), // 관광지 탭 추가 해야함
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
                  scheduleService.foodAndPlaceItemsList.length < 5
                      ? ElevatedButton(
                          onPressed: null,
                          child: Text(
                              '${5 - scheduleService.foodAndPlaceItemsList.length}곳을 더 선택해주세요'), //font 적용하기
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            minimumSize: Size(300, 48),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScheduleComplete(
                                        daysTabBar: 3, // 2박 3일 더미데이터
                                      ),
                                  fullscreenDialog: true),
                            );
                          },
                          child: Text('확인'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(221, 81, 37, 1),
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
