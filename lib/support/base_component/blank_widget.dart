import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget Blank({double height = 2, Color? color}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 15),
    height: height,
    color: color == null ? Color(0xFFE5E5E5) : color,
  );
}

Widget mainLogo() {
  return SvgPicture.asset(
    'assets/images/ustain_text_logo_white.svg',
    width: 100,
    color: Colors.white,
  );
}
