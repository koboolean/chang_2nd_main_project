import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/event_dialog.dart';

class EventBanner extends ChangeNotifier {
  late bool isDoneEvent; //이벤트 참가완료 여부확인
  int placeInfoVisitClick = 0; //Place_info 클릭 횟수 3번 이상
  // Place, Place_List, Search_page 내 navigatior 페이지 이동 체크
  // 페이지 방문 여부의 고정 배열
  var pageVisitClick = List<bool>.empty(growable: true);

  getEventIsDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 테스트용 나중에 삭제 해야함
    //prefs.clear();
    isDoneEvent = prefs.getBool('isDoneEvent') ?? false;
    return isDoneEvent;
  }

  setEventIsDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isDoneEvent', !isDoneEvent);
    // print('setEventisDone $isDoneEvent');
  }

  // getEventComplete() {}
  // setEventComplete(bool isDone) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.setBool('eventComplete', isDone);
  // }

  void increaseClick(BuildContext context) async {
    ++placeInfoVisitClick;
    if (isDoneEvent == false &&
        placeInfoVisitClick >= 3 &&
        pageVisitClick.length >= 2) {
      //isDoneEvent = !isDoneEvent;
      //setEventIsDone();

      //이벤트 팝업창
      dialogBuilder(context);
    }
    // print('방문클릭 $placeInfoVisitClick');
  }
}
