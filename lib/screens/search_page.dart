import 'package:chang_2nd_main_project/model/foodInfo.dart';
import 'package:chang_2nd_main_project/model/lodgeInfo.dart';
import 'package:chang_2nd_main_project/model/placeInfo.dart';
import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/services/search_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/searchUndefined.dart';

class MySearch extends StatefulWidget {
  MySearch({Key? key}) : super(key: key);

  @override
  _MySearchState createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> with SingleTickerProviderStateMixin{
   //검색 리스트 확인 부분 입력
  String type = "";

  String name = "";
  final _controller = TextEditingController();
  //late TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(text: '맛집'),
    Tab(text: "숙소"),
    Tab(text: "관광지"),
  ];


  /*@override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);

    _tabController.addListener(handleTabSelection);
  }*/

  /*void handleTabSelection() async {
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
    }
    Consumer<SearchService>(
      builder: (context, searchService, child){
        return FutureBuilder<QuerySnapshot>(
            future: searchService.foodRead(type),
            builder: (context, snapshot) {
            final docs = snapshot.data?.docs ?? []; // 문서들 가져오기
            if (docs.isEmpty) {
              return showUndfinedValue();
            }else{
              return selectSearchValue(docs);
            }
          },
        );
      }
    );
  }*/

  Expanded selectSearchValue(List<QueryDocumentSnapshot<Object?>> docs, type) {
      var arr = [];
      for(var doc in docs){
        var selNm = doc.get("name");
        if(selNm.toString().contains(name)) {
          final Object send;
          if(type == "food"){
            String foodSubtitle = doc.get('Subtitle');
            String foodAddress = doc.get('address');
            String foodBusinessHours = doc.get('businessHours');
            String foodClassification = doc.get('classification');
            String foodField14 = doc.get('field14');
            String foodIdx = doc.get('idx');
            String foodNaverLink = doc.get('naverlink');
            String foodNote = doc.get('note');
            String foodPhonenumber = doc.get('phoneNumber');
            String foodPrice = doc.get('price');
            String foodServingSize = doc.get('servingSize');
            String foodName = doc.get('name');
            String foodUrl1 = doc.get('url1');
            String foodUrl2 = doc.get('url2');
            String foodArea = doc.get('area');

            send = FoodInfoModel(
                foodArea,
                foodName,
                foodAddress,
                foodUrl1,
                foodSubtitle,
                foodAddress,
                foodArea,
                foodBusinessHours,
                foodClassification,
                foodField14,
                foodIdx,
                foodName,
                foodNaverLink,
                foodNote,
                foodPhonenumber,
                foodPrice,
                foodServingSize,
                foodUrl1,
                foodUrl2);
          }else if(type == "lodge"){
            String lodgeBreakFastYn = doc.get('BreakfastYn');
            String lodgeSubtitle = doc.get('Subtitle');
            String lodgeAddress = doc.get('address');
            String lodgeArea = doc.get('area');
            String lodgeBusinessHours = doc.get('businessHours');
            String lodgeIdx = doc.get('idx');
            String lodgeName = doc.get('name');
            String lodgeNaverLink = doc.get('naverlink');
            String lodgePartyYn = doc.get('partyYn');
            String lodgePhoneNumber = doc.get('phoneNumber');
            String lodgePriceType1 = doc.get('priceType1');
            String lodgePriceType2 = doc.get('priceType2');
            String lodgePriceType3 = doc.get('priceType3');
            String lodgeToiletYn = doc.get('toiletYn');
            String lodgeUrl1 = doc.get('url1');
            String lodgeUrl2 = doc.get('url2');

            send = LodgeInfoModel(
                lodgeArea,
                lodgeName,
                lodgeAddress,
                lodgeUrl1,
                lodgeBreakFastYn,
                lodgeSubtitle,
                lodgeAddress,
                lodgeArea,
                lodgeBusinessHours,
                lodgeIdx,
                lodgeName,
                lodgeNaverLink,
                lodgePartyYn,
                lodgePhoneNumber,
                lodgePriceType1,
                lodgePriceType2,
                lodgePriceType3,
                lodgeToiletYn,
                lodgeUrl1,
                lodgeUrl2);
          }else{
            String placeAddress = doc.get('address');
            String placeArea = doc.get('area');
            String placeBusinessHours = doc.get('businessHours');
            String placeClassifiaction = doc.get('classification');
            String placeField13 = doc.get('field13');
            String placeIdx = doc.get('idx');
            String placeName = doc.get('name');
            String placeNaverLink = doc.get('naverlink');
            String placeNote = doc.get('note');
            String placePhoneNumber = doc.get('phoneNumber');
            String placePrice = doc.get('price');
            String placeSubtitle = doc.get('subTitle');
            String placeUrl1 = doc.get('url1');
            String placeUrl2 = doc.get('url2');

            send = PlaceInfoModel(
                placeArea,
                placeName,
                placeAddress,
                placeUrl1,
                placeAddress,
                placeArea,
                placeBusinessHours,
                placeClassifiaction,
                placeField13,
                placeIdx,
                placeName,
                placeNaverLink,
                placeNote,
                placePhoneNumber,
                placePrice,
                placeSubtitle,
                placeUrl1,
                placeUrl2);
          }

          arr.add(send);
        }
      }
      return Expanded(
          child: GridView.builder(
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio:
          0.8),
          itemCount: arr.length,
          itemBuilder: (context, index) {
            var data = arr[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlaceInfo(
                                  placetoreceive: data,
                                )),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey,

                            //사진 삽입
                            image: DecorationImage(
                              image: NetworkImage(data.url1),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: double.maxFinite,
                          height: 142, //실제 높이 142-16 = 126
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 28,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              data.area,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x9e000000),
                                    offset: Offset(0, 2),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 9.0, left: 15.0, bottom: 2.0, right: 14),
                  child: Text(
                    data.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 2.0, left: 15.0, bottom: 14.0, right: 14),
                  child: Text(
                    data.address,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700]!,
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                ),
              ],
            );
          }
          )
      );
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
                  //controller: _tabController,
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
                    (name=="") ?
                    showUndfinedValue() :
                    Padding(
                      padding: const EdgeInsets.only(top:50.0),
                      child: Consumer<SearchService>(
                          builder: (context, searchService, child){
                            return FutureBuilder<QuerySnapshot>(
                              future: searchService.foodRead(),
                              builder: (context, snapshot) {
                                final docs = snapshot.data?.docs ?? []; // 문서들 가져오기
                                if (docs.isEmpty) {
                                  return showUndfinedValue();
                                }else{
                                  return selectSearchValue(docs, "food");
                                }
                              },
                            );
                          }
                      ),
                    ),
                    (name=="") ?
                    showUndfinedValue() :
                    Padding(
                      padding: const EdgeInsets.only(top:50.0),
                      child: Consumer<SearchService>(
                          builder: (context, searchService, child){
                            return FutureBuilder<QuerySnapshot>(
                              future: searchService.lodgeRead(),
                              builder: (context, snapshot) {
                                final docs = snapshot.data?.docs ?? []; // 문서들 가져오기
                                if (docs.isEmpty) {
                                  return showUndfinedValue();
                                }else{
                                  return selectSearchValue(docs, "lodge");
                                }
                              },
                            );
                          }
                      ),
                    ),
                    (name=="") ?
                    showUndfinedValue() :
                    Padding(
                      padding: const EdgeInsets.only(top:50.0),
                      child: Consumer<SearchService>(
                          builder: (context, searchService, child){
                            return FutureBuilder<QuerySnapshot>(
                              future: searchService.placeRead(),
                              builder: (context, snapshot) {
                                final docs = snapshot.data?.docs ?? []; // 문서들 가져오기
                                if (docs.isEmpty) {
                                  return showUndfinedValue();
                                }else{
                                  return selectSearchValue(docs, "place");
                                }
                              },
                            );
                          }
                      ),
                    )
                  ],),
                )
              ]
          ),
        )
        )
    );
  }
}
