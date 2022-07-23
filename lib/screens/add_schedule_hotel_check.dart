import 'package:chang_2nd_main_project/screens/login.dart';
import 'package:chang_2nd_main_project/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import '../services/auth_service.dart';

const double _kItemExtent = 32.0;
const List<String> _transportation = <String>[
  '자차',
  '도보'
];

/// 홈페이지
class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  State<AddSchedule> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedule> {
  TextEditingController jobController = TextEditingController();
  int selectedTrans = 0;

  @override
  Widget build(BuildContext context) {

    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return Consumer(
      builder: (context, bucketService, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(1, 1, 1, 0),
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.close, color: Colors.black,),
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
          body: Container(
            margin: EdgeInsets.all(20),
            child:Column(
              children: [
                Row(children: [
                  Text(
                    '제주도',
                    style: TextStyle(
                      color: Color.fromRGBO(221, 81, 37, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_down,
                      color: Color.fromRGBO(131, 123, 117, 1),),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 220,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 30),
                                  Row(
                                    children: [
                                      Text("아직 제주도 밖에\n서비스를 제공하지 않아요 🙏",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'SpoqaHanSansNeo',
                                          fontWeight: FontWeight.w700,
                                        ),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('향후 지역을 더 키워나갈 예정입니다.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromRGBO(90, 86, 82, 1),
                                          fontSize: 13,
                                          fontFamily: 'SpoqaHanSansNeo',
                                        ),
                                      ),
                                    ],
                                  )

                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text("를", style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500
                    ),),
                  ),
                  Text(
                    '3박 4일',
                    style: TextStyle(
                      color: Color.fromRGBO(221, 81, 37, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_down,
                      color: Color.fromRGBO(131, 123, 117, 1),),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 376,
                            color: Colors.white,
                          );
                        },
                      );
                    },),
                ]),
                SizedBox(height: 10),
                Row(
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => showsDialog(
                        context,
                          CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: _kItemExtent,
                            // This is called when selected item is changed.
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                                selectedTrans = selectedItem;
                              });
                            },
                            children:
                            List<Widget>.generate(_transportation.length, (int index) {
                              return Center(
                                child: Text(
                                  _transportation[index],
                                ),
                              );
                            }),
                          ),
                        300
                      ),
                    child: Row(children: [
                      Text(
                        _transportation[selectedTrans],
                        style: TextStyle(
                          color: Color.fromRGBO(221, 81, 37, 1),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down,
                        color: Color.fromRGBO(131, 123, 117, 1),)
                    ],),),

                    Text("를 이용해",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500)
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("하루 최대  ",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500)
                    ),
                    Text(
                      '5',
                      style: TextStyle(
                        color: Color.fromRGBO(221, 81, 37, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_drop_down,
                        color: Color.fromRGBO(131, 123, 117, 1),),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 376,
                              color: Colors.white,

                            );
                          },
                        );
                      },),

                    Text("곳을 갈거야",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500)
                    )
                  ],
                ),

                SizedBox(height: 30,),
                Row(
                  children: [
                    Text("선택사항",
                      style: TextStyle(
                        color: Color.fromRGBO(90, 86, 82, 1),
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("숙소는",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  '제주도',
                  style: TextStyle(
                    color: Color.fromRGBO(221, 81, 37, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(221, 81, 37, 1))),
                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(221, 81, 37, 1))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width : 3,color: Color.fromRGBO(221, 81, 37, 1))),
                    hintText: "내 숙소 검색하기",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search,
                        color: Color.fromRGBO(221, 81, 37, 1),),
                      onPressed: () {
                      },
                    )
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    child: Text("확인"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(221, 81, 37, 1),),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(100),
                        )
                      )
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        shape: const RoundedRectangleBorder( // <-- SEE HERE
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40.0),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return Container(
                            height: 441,
                            padding: EdgeInsets.all(23),
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('이런 숙소는 어떠세요?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'SpoqaHanSansNeo',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: ElevatedButton(onPressed: () {  },child: Text("계획 마저 세우기", style: TextStyle(color: Color.fromRGBO(90, 86, 82, 1)),),
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(238, 238, 238, 1)), )
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: ElevatedButton(onPressed: () {  },child: Text("추천 숙소보기"),
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(221, 81, 37, 1),),),),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ]
            ),
          ),

        );
      },
    );
  }
}