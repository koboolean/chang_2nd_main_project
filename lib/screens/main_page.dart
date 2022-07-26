import 'package:chang_2nd_main_project/screens/add_schedule.dart';
import 'package:chang_2nd_main_project/screens/favorite_city.dart';
import 'package:chang_2nd_main_project/screens/favorite_list.dart';
import 'package:chang_2nd_main_project/screens/place.dart';
import 'package:chang_2nd_main_project/screens/mypage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Place(),
    FavoriteCity(),
    AddSchedule(),
    MyPage()
  ];
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: _children[_currentIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _onTap,
            currentIndex: _currentIndex,
            selectedItemColor: Color.fromRGBO(221, 81, 37, 1),
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('images/home.svg', width: 10, height: 10),
                label: '홈',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '찜한곳'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.flight_takeoff_outlined), label: '여행계획'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'MY'),
            ],
          ),
        ));
  }
}
