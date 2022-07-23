import 'package:chang_2nd_main_project/screens/add_schedule.dart';
import 'package:chang_2nd_main_project/screens/favorite_list.dart';
import 'package:chang_2nd_main_project/screens/home.dart';
import 'package:chang_2nd_main_project/screens/select_want_to_go.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 2;

  final List<Widget> _children = [HomePage(), FavoritePage_Room(), AddSchedule(), SelectWantToGo()];
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _onTap,
          currentIndex: _currentIndex,
          selectedItemColor: Color.fromRGBO(221, 81, 37, 1),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem( icon: Icon(Icons.favorite), label: '찜한곳'),
            BottomNavigationBarItem( icon: Icon(Icons.flight_takeoff_outlined), label: '여행계획'),
            BottomNavigationBarItem( icon: Icon(Icons.account_circle), label: 'MY'),
          ],
        )
    );
  }
}