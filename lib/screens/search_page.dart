import 'package:chang_2nd_main_project/services/auth_service.dart';
import 'package:chang_2nd_main_project/services/search_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../widgets/searchUndefined.dart';

class MySearch extends StatefulWidget {
  MySearch({Key? key}) : super(key: key);

  @override
  _MySearchState createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> with SingleTickerProviderStateMixin{
  var _context;


  //검색 리스트 확인 부분 입력
  String type = "";

  //검색연산자 입력
  String name = "";
  final _controller = TextEditingController();
  late TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(text: '맛집'),
    Tab(text: "숙소"),
    Tab(text: "관광지"),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);

    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          type = "food";
          break;
        case 1:
          type = "lodge";
          break;
        case 2:
          type = "place";
          break;
      }
      print(type);
    }
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
        //Appbar
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          //검색창
          title: SizedBox(
            height: 40,
            width: double.infinity,
            child: TextField(
              controller: _controller, //textfield 수정연산자
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(221, 81, 37, 1)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(221, 81, 37, 1)),
                ),
                filled: true,
                fillColor: Color.fromRGBO(243, 243, 243, 1),
                hintText: "가고 싶은 곳을 검색하세요.",
                suffixIcon: IconButton(
                  onPressed: _controller.clear,
                  icon: Icon(
                    Icons.cancel_rounded,
                    color: Color.fromRGBO(221, 81, 37, 1),
                    size: 18,
                  ),
                ),

              ),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
              onSubmitted: (v) {
                // 엔터를 누르는 경우
              },
            ),
          ),
          actions: [
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: SafeArea(
          child: Column(
              children:[
                TabBar(
                  controller: _tabController,
                  tabs: myTabs,
                  indicatorColor: Color.fromRGBO(221, 81, 37, 1),
                  labelColor: Color.fromRGBO(221, 81, 37, 1),
                  indicatorWeight: 3,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    showUndfinedValue(),
                    showUndfinedValue(),
                    showUndfinedValue()
                  ],),
                )
              ]
          ),
        )
        )
    );
  }
}
