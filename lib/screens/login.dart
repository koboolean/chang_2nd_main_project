import 'package:chang_2nd_main_project/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

/// 로그인 페이지
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final user = authService.currentUser();
        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
               image: AssetImage("assets/images/login_background.jpeg"),
                fit: BoxFit.fill,
              )
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  SizedBox(height: 120),

                  Image.asset("assets/images/icon_image.png", height: 200, width: 300,),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    child: Text("1인 여행의 모든 것,\n'서비스이름'",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,

                      ),

                    ),
                  ),
                  SizedBox(height: 80),
                  /// 로그인 버튼
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: IconButton(
                      icon: Image.asset("assets/images/kakao_login_medium_wide.png"),
                      iconSize: 80.0,
                      onPressed: () {
                        // 로그인
                        authService.signIn(
                          email: "koboolean@gmail.com",
                          password: "guswns123!",
                          onSuccess: () {
                            // 로그인 성공
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("로그인 성공"),
                            ));

                            // HomePage로 이동
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          },
                          onError: (err) {
                            // 에러 발생
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(err),
                            ));
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Photo by Doyle Shin on Unsplash",
                      style: TextStyle(color: Colors.white,
                        fontSize: 8,
                        fontFamily: 'SpoqaHanSansNeo',
                        fontWeight: FontWeight.w700,)),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
