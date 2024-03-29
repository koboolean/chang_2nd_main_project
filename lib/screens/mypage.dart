import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yaml/yaml.dart';

import '../services/auth_service.dart';

/// 홈페이지
class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    final ValueNotifier<String> version =
        ValueNotifier<String>("1.0"); // ValueNotifier 변수 선언

    rootBundle.loadString("pubspec.yaml").then((yamlValue) {
      var yaml = loadYaml(yamlValue);
      version.value = yaml['version'].toString().split("+")[0];
    });

    return Consumer(
      builder: (context, bucketService, child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  "마이페이지",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 31,
              ),
              Column(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child:  (user.displayName == null) ?
                      Icon(Icons.account_circle, size: 158,
                            color: Colors.grey,):
                      Image.network(user.photoURL.toString(),
                          width: 158, height: 158, fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    (user.displayName != null) ? '${user.displayName}' : "IOS사용자",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${user.email}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(128, 128, 128, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Container(
                height: 7,
                decoration: BoxDecoration(
                  color: Color(0xfff3f3f3),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  children: [
                    Text(
                      "앱 설정",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 23,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 30.0),
                child: Row(
                  children: [
                    Text(
                      "앱 버전",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    SizedBox(width: 200),
                    ValueListenableBuilder(
                      valueListenable: version,
                      builder:
                          (BuildContext context, String value, Widget? child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(version.value,
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: Row(
                  children: [
                    Text(
                      "로그아웃",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // 로그아웃
                        context.read<AuthService>().signOut();

                        // 로그인 페이지로 이동
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
