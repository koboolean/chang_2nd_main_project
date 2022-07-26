import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:chang_2nd_main_project/screens/main_page.dart';
import 'package:chang_2nd_main_project/services/auth_service.dart';
import 'package:chang_2nd_main_project/services/schedule_service.dart';
import 'package:chang_2nd_main_project/services/travel_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(); // firebase 앱 시작
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => TravelService()),
        ChangeNotifierProvider(create: (context) => ScheduleService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthService>().currentUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'SpoqaHanSansNeo',
          primaryColor: Color.fromRGBO(221, 81, 37, 1),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color.fromRGBO(221, 81, 37, 1))),
      home: user == null ? LoginPage() : HomePage(),
    );
  }
}
