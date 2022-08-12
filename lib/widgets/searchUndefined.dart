import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Center showUndfinedValue(){
  return Center(
    child: Column(
      mainAxisAlignment : MainAxisAlignment.center,
      crossAxisAlignment : CrossAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: SvgPicture.asset(
            'assets/images/sad.svg',
            height: 50,
            width: 50,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "검색어를 입력해주세요",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(height: 10),

        SizedBox(height: 100),
      ],
    ),
  );
}
