

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

Widget favoriteCheck(ceckVal){
  return ValueListenableBuilder(
      valueListenable: ceckVal,
      builder: (BuildContext context, bool value, Widget? child) {
        return value
            ? SvgPicture.asset(
          'assets/images/hearTrue.svg',
          width: 27,
          height: 27,
        )
            : SvgPicture.asset(
          'assets/images/heartFalse.svg',
          width: 27,
          height: 27,
        );
      }
  );
}