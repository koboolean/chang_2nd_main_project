import 'package:chang_2nd_main_project/services/event_service.dart';
import 'package:chang_2nd_main_project/widgets/url_launch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:provider/provider.dart';

Future<void> dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // 바깥 여백 터치시 대화 상자를 닫을 수 있는지 여부
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Stack(
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.rectangle),
              child: Image.asset(
                'assets/images/event_banner2.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 630,
              right: MediaQuery.of(context).size.width - 350,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 24,
                  color: Colors.white,
                ),
                onPressed: () {
                  //EventBanner 클래스 변수들 초기화 해서 다시 조건에 맞으면 팝업노출
                  //context.read<EventBanner>().setEventIsDone();
                  context.read<EventBanner>().placeInfoVisitClick = 0;
                  context.read<EventBanner>().pageVisitClick.clear();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
            bottom: Radius.circular(25),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        //actionsPadding: EdgeInsets.symmetric(horizontal: 22),
        actions: <Widget>[
          Column(
            children: [
              Container(
                width: 245,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    backgroundColor: Color.fromRGBO(221, 81, 37, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    '후기 알려주기',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    await context.read<EventBanner>().setEventIsDone();
                    launchInBrowser(Uri.parse(
                        'https://docs.google.com/forms/d/1ZksVpUqnPvmQhCpwLx-NlP5IgTVd6Dkx-Icah6CEVgk/edit?usp=drivesdk'));
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 245,
                height: 40,
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    backgroundColor: Color.fromRGBO(210, 210, 210, 0.38),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    '다시 보지 않기',
                    style: TextStyle(
                      color: Colors.black26,
                    ),
                  ),
                  onPressed: () {
                    //EventBanner 클래스 변수들 초기화 해서 다시 조건에 맞으면 팝업노출
                    //context.read<EventBanner>().setEventIsDone();
                    context.read<EventBanner>().placeInfoVisitClick = 0;
                    context.read<EventBanner>().pageVisitClick.clear();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}

//다시 보지 않기 버튼 누를시 초기화
//  placeInfoVisitClick = 0; //Place_info 클릭 횟수 3번 이상
//   // Place, Place_List, Search_page 내 navigatior 페이지 이동 체크
//   // 페이지 방문 여부의 고정 배열
//   var pageVisitClick