import 'package:flutter/material.dart';

void showTobeContinue(context) {
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
                  Text(
                    "아직 기능구현이 되지 않았어요 🙏",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    '빠른시일 내로 구현하도록 하겠습니다.',
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
}
