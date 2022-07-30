import 'dart:io';

import 'package:chang_2nd_main_project/screens/main_page.dart';
import 'package:chang_2nd_main_project/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;

/// 로그인 페이지
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  googleLogin(authService) async{
    authService.loginWithGoogle(
      onSuccess : (){
        // 로그인 성공
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("로그인 성공"),
        ));

        // HomePage로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()),
        );
      },
      onError: (err) {
        // 에러 발생
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("로그인이 실패하였습니다."),
        ));
      },
    );
  }

  loginService(authService){
    // 로그인
    authService.signIn(
      email: "aa@naver.com",
      password: "123123",
      onSuccess: () {
        // 로그인 성공
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("로그인 성공"),
        ));

        // HomePage로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()),
        );
      },
      onError: (err) {
        // 에러 발생
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err),
        ));
      },
    );

  }

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
                image : AssetImage("assets/images/login_title.jpeg"),
                fit: BoxFit.fitWidth
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/2-100,),
                Column(
                  children: [
                    Text('1인 여행의 모든 것',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'SpoqaHanSansNeo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Image(image: svg_provider.Svg("assets/images/title_logo.svg", size: Size(153,36))),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    MaterialButton(
                      child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/google_login.png"),
                                fit: BoxFit.fill),
                          )
                      ),
                      // ),
                      onPressed: () async{
                        googleLogin(authService);
                      },
                    ),
                    SizedBox(height: 12),
                    Platform.isIOS ?
                        Column(
                          children: [
                            MaterialButton(
                              child: Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/apple_login.png"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              // ),
                              onPressed: () {
                                loginService(authService);
                              },
                            ),
                            SizedBox(height: 73,)
                          ],
                        )
                        : SizedBox(height: 130,)
                  ],),
              ],
            )
            )
        );
      },
    );
  }
}
