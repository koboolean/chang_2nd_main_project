import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:chang_2nd_main_project/services/schedule_service.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScheduleComplete extends StatefulWidget {
  ScheduleComplete({super.key, required this.daysTabBar});
  late int daysTabBar;
  @override
  State<ScheduleComplete> createState() => _ScheduleCompleteState();
}

class _ScheduleCompleteState extends State<ScheduleComplete>
    with TickerProviderStateMixin {
  WebViewController? controller;
  Set<JavascriptChannel>? channel;

  late TabController TabBarController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    TabBarController = TabController(length: widget.daysTabBar, vsync: this);
  }

  // @override
  // void dispose() {
  //   TabBarController.dispose();
  //   super.dispose();
  // }

  void _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/ref/index.html');
    controller!.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleService>(
      builder: (context, scheduleService, child) {
        var totalChecked = scheduleService.checkedList;
        return DefaultTabController(
          initialIndex: 0,
          length: 6,
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
                              return WebView(
                                // initialUrl: 'https://flutter.dev',
                                javascriptMode: JavascriptMode.unrestricted,
                                onProgress: (progress) {
                                  print(
                                      'WebView is loading (progress : $progress%)');
                                },
                                onWebViewCreated: (controller) {
                                  this.controller = controller;
                                  _loadHtmlFromAssets();
                                },
                                javascriptChannels: channel,
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
                              for (int i = 0; i <= TabBarController.length; i++)
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
                //height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
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
                              onPressed: () {},
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
                        itemCount: totalChecked.length,
                        itemBuilder: (context, index) {
                          var totalList = totalChecked[index];
                          return ListTile(
                            leading: FlutterLogo(size: 56.0),
                            title: Row(
                              children: [
                                Text(totalList.name),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(totalList.category),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Icon(Icons.place_outlined),
                                SizedBox(
                                  width: 3.5,
                                ),
                                Text(totalList.address),
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
