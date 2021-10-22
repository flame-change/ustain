import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget Blank() {
  return Container(
    height: Adaptive.h(2),
    color: Color(0xFFE5E5E5),
  );
}

Widget mainLogo() {
  return SvgPicture.asset(
    'assets/images/ustain_text_logo_white.svg',
    width: 100,
    color: Colors.white,
  );
}
