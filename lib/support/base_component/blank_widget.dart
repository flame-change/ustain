import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget Blank({double height = 2, Color? color}) {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      height: height,
      color: color == null ? Color(0xFFE5E5E5) : color);
}

Widget mainLogo() {
  return Image.asset('assets/images/logo_main.png',
      width: 100, color: Colors.white);
}
