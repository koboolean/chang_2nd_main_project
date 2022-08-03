import 'package:chang_2nd_main_project/screens/favorite_list.dart';
import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:chang_2nd_main_project/screens/notification.dart';
import 'package:chang_2nd_main_project/screens/place_info.dart';
import 'package:chang_2nd_main_project/screens/place_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chang_2nd_main_project/services/travel_service.dart';
import 'package:chang_2nd_main_project/screens/search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class MySearch extends StatefulWidget {
  MySearch({Key? key}) : super(key: key);

  @override
  _MySearchState createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  //검색연산자 입력
  String name = "";
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              filled: true,
              fillColor: Color.fromRGBO(243, 243, 243, 1),
              hintText: "가고 싶은 곳을 검색하세요.",
              suffixIcon: IconButton(
                onPressed: _controller.clear,
                icon: Icon(
                  Icons.cancel_rounded,
                  size: 18,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
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
        //오른쪽 취소 버튼
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.pop(context, false);
                // 돋보기 아이콘 클릭
              },
            ),
          ),
        ],
      ),
      //bodt
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? FirebaseFirestore.instance
                .collection('name')
                .where("name", arrayContains: name)
                .snapshots()
            : FirebaseFirestore.instance.collection('foodArea').snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return Container(
                        padding: EdgeInsets.only(left: 18, right: 18),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                //Navigator.push(
                                //  context,
                                //  MaterialPageRoute(
                                //      builder: (context) => PlaceInfo(
                                //            sendName: ('소랑드르'),
                                //          )),
                                //);
                              },
                              child: ListTile(
                                //검색 제목결과
                                title: Text(
                                  data['name'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                //지역 제목결과
                                subtitle: Text(
                                  data['area'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff8f8f8f),
                                  ),
                                ),
                                leading: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.network(
                                      data['url'],
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                          ],
                        ));
                  }));
        },
      ),
    );
  }
}
