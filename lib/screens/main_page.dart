import 'package:chang_2nd_main_project/screens/favorite_city.dart';
import 'package:chang_2nd_main_project/screens/place.dart';
import 'package:chang_2nd_main_project/screens/mypage.dart';
import 'package:chang_2nd_main_project/services/auth_service.dart';
import 'package:chang_2nd_main_project/services/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
    //AddSchedule(),
    MyPage()
  ];
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;

    /// 로그인 관련 애널리틱스 반영
    loginAnalyticsLog(user.uid);

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
              icon: SvgPicture.asset(
                'assets/images/home.svg',
              ),
              activeIcon: SvgPicture.asset(
                'assets/images/home.svg',
                color: Color.fromRGBO(221, 81, 37, 1),
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/favorite.svg',
                ),
                activeIcon: SvgPicture.asset(
                  'assets/images/favorite.svg',
                  color: Color.fromRGBO(221, 81, 37, 1),
                ),
                label: '찜한곳'),
            /*BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/airplane.svg',
                ),
                activeIcon: SvgPicture.asset(
                  'assets/images/airplane.svg',
                  color: Color.fromRGBO(221, 81, 37, 1),
                ),
                label: '여행계획'),*/
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/user.svg',
                ),
                activeIcon: SvgPicture.asset(
                  'assets/images/user.svg',
                  color: Color.fromRGBO(221, 81, 37, 1),
                ),
                label: 'MY'),
          ],
        ),
      ),
    );
  }
}
