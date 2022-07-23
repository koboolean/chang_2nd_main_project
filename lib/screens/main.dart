import 'package:chang_2nd_main_project/screens/add_schedule.dart';
import 'package:chang_2nd_main_project/screens/home.dart';
import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:chang_2nd_main_project/services/auth_service.dart';
import 'package:chang_2nd_main_project/services/schedule_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'select_want_to_go.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(); // firebase 앱 시작
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
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
      home: user == null ? LoginPage() : AddSchedule(), //SelectWantToGo()
    );
  }
}
