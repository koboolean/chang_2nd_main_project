import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

/// 홈페이지
class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  State<AddSchedule> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedule> {
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return Consumer(
      builder: (context, bucketService, child) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Image.asset("assets/images/notebook.png"),
                        onPressed: (){
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
              ),

              Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: Text("제주도를 3박 4일\n자차를 이용해\n하루 최대 5곳을 갈꺼야",
                      textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 1.0,
                          height:1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 280.0),
                      child:Text('추가 선택',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 130.0),
                      child:Text("숙소는 000 이야",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 1.0,
                          height:1.4,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}