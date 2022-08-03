import 'dart:convert';
//import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:chang_2nd_main_project/services/schedule_service.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class ScheduleComplete extends StatefulWidget {
  ScheduleComplete({super.key, required this.daysTabBar});
  final int daysTabBar;
  @override
  State<ScheduleComplete> createState() => _ScheduleCompleteState();
}

class _ScheduleCompleteState extends State<ScheduleComplete>
    with TickerProviderStateMixin {
  WebViewPlusController? _controller;
  WebViewController? _webViewController;
  //Set<JavascriptChannel>? channel;
  late Position position;
  late TabController TabBarController;

  @override
  void initState() {
    TabBarController = TabController(length: widget.daysTabBar, vsync: this);
    super.initState();
  }

  // @override
  // void dispose() {
  //   TabBarController.dispose();
  //   super.dispose();
  // }

  //html 로컬파일 불러오기
  void _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/ref/index.html');
    _controller!.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleService>(
      builder: (context, scheduleService, child) {
        var totalCheckedList = scheduleService.foodAndPlaceItemsList;
        return DefaultTabController(
          initialIndex: 0,
          length: TabBarController.length,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/trash.png',
                    ),
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
                  preferredSize: Size.fromHeight(300), //431
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
                            ],
                          ),
                        ),
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.grey),
                          child: Builder(
                            builder: (context) {
                              return WebViewPlus(
                                initialUrl: 'assets/ref/index.html',
                                javascriptMode: JavascriptMode.unrestricted,
                                onProgress: (progress) {
                                  //print(
                                  //    'WebView is loading (progress : $progress%)');
                                },
                                onWebViewCreated: (controller) {
                                  _controller = controller;
                                  _webViewController =
                                      controller.webViewController;
                                },
                                onPageFinished: (url) async {
                                  position =
                                      await Geolocator.getCurrentPosition(
                                          desiredAccuracy:
                                              LocationAccuracy.high);
                                  _webViewController?.runJavascript(
                                      'currentLocation(' +
                                          position.latitude.toString() +
                                          ',' +
                                          position.longitude
                                              .toString()
                                              .replaceAll("-", "") +
                                          ')');
                                },
                                javascriptChannels: <JavascriptChannel>{
                                  JavascriptChannel(
                                    name: 'JavascriptChannel',
                                    onMessageReceived:
                                        //message ->script.js 파일의 JavascriptChannel.pstMessage() 에서 넘어온 데이터
                                        (JavascriptMessage message) {
                                      print(
                                          "message from the web view=\"${message.message}\"");
                                    },
                                  )
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: TabBar(
                            controller:
                                TabBarController, //TabBarController.length
                            isScrollable: true, //TabBar 스크롤 가능
                            labelColor: Color.fromRGBO(221, 81, 37, 1),
                            tabs: [
                              for (int i = 0; i < TabBarController.length; i++)
                                Tab(
                                  text: '${i + 1}일차',
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: Container(
                padding: EdgeInsets.only(left: 18, top: 10, right: 18),
                child: TabBarView(
                  children: [
                    Scaffold(
                      appBar: AppBar(
                        leadingWidth: 0,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                // _controller!.webViewController
                                //     .evaluateJavascript('currentLocation()');
                              },
                              icon: Image.asset('assets/images/align.png'),
                              label: Text(
                                '최적 경로로 수정',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Spacer(),
                            Text(
                              //ReorderableListView 위젯 : 목록 재정렬
                              '편집',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      body: ListView.separated(
                        itemCount: totalCheckedList.length,
                        itemBuilder: (context, index) {
                          var totalList = totalCheckedList[index];
                          //DisplaySelectList itemList = DisplaySelectList(name:totalCheckedList[index].na , classification: classification, address: address, imageUrl: imageUrl, idx: idx, lat: lat, long: long)
                          return ListTile(
                            leading: SizedBox(
                              height: 56,
                              width: 56,
                              child: Image.network(
                                totalCheckedList[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                            title: Row(
                              children: [
                                //Text(totalList.name),
                                SizedBox(
                                  width: 6,
                                ),
                                // Text(totalList.classification),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Icon(Icons.place_outlined),
                                SizedBox(
                                  width: 3.5,
                                ),
                                //Text(totalList.address),
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
                              Text('차로 30 분 소요'),
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
                      ),
                    ),
                    Text('2일차 경로'),
                    Text('3일차 경로'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
