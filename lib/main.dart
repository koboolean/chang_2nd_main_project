import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:chang_2nd_main_project/screens/splash.dart';
import 'package:chang_2nd_main_project/services/auth_service.dart';
import 'package:chang_2nd_main_project/services/favorite_button.dart';
import 'package:chang_2nd_main_project/services/favorite_service.dart';
import 'package:chang_2nd_main_project/services/schedule_service.dart';
import 'package:chang_2nd_main_project/services/search_service.dart';
import 'package:chang_2nd_main_project/services/travel_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
//import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(); // firebase 앱 시작
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => TravelService()),
        ChangeNotifierProvider(create: (context) => ScheduleService()),
        ChangeNotifierProvider(create: (context) => FavoriteFoodService()),
        ChangeNotifierProvider(create: (context) => FavoriteLodgeService()),
        ChangeNotifierProvider(create: (context) => FavoritePlaceService()),
        ChangeNotifierProvider(create: (context) => FavoriteListService()),
        ChangeNotifierProvider(create: (context) => SearchService()),
        ChangeNotifierProvider(create: (context) => FavoriteButton()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    /*_determinePosition();*/ //위치 관련 권한
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthService>().currentUser();
    return MaterialApp(
      ////////////////// 날짜 한글번역 설정 ///////////////
      localizationsDelegates: const [
        // delegate from flutter_localization
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // delegate from localization package.
        // LocalJsonLocalization.delegate,
      ],
      supportedLocales: const [Locale('ko', 'KR')],
      locale: const Locale('ko'),
      ////////////////////////////////////////////////////
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'SpoqaHanSansNeo',
          primaryColor: Color.fromRGBO(221, 81, 37, 1),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color.fromRGBO(221, 81, 37, 1))),
      home: user == null ? LoginPage() : SplashPage(),
    );
  }
}


/*Future<Position> _determinePosition() async {
  //모바일 위치 권한 설정
  //bool serviceEnabled;
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }


  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}*/
