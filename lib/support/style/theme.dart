import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

final theme = ThemeData(
  dividerColor: Color(0xFFC2C2C2),
  primarySwatch: Colors.pink,
  fontFamily: 'Poppins',
  backgroundColor: const Color(0xFF121212),
  focusColor: const Color(0xFFDE1568),
  scaffoldBackgroundColor: const Color(0xFF121212),
  accentColor: const Color(0xFFDE1568),
  primaryColor: const Color(0xFFDE1568),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.only(left: 11, bottom: 10, top: 10, right: 11),
    labelStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: Adaptive.dp(14),
        fontWeight: FontWeight.w300),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1, color: const Color(0xFFDE1568))),
  ),
  textTheme: TextTheme(
      headline1: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Adaptive.dp(40),
          fontWeight: FontWeight.w900,
          color: Colors.white),
      headline2: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Adaptive.dp(30),
          fontWeight: FontWeight.w900,
          color: Colors.white),
      headline3: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Adaptive.dp(25),
          fontWeight: FontWeight.w900,
          color: Colors.white),
      headline4: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Adaptive.dp(20),
          fontWeight: FontWeight.w700,
          color: Colors.white),
      headline5: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Adaptive.dp(15),
          fontWeight: FontWeight.w700,
          color: Colors.white),
      headline6: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Adaptive.dp(12),
          fontWeight: FontWeight.w700,
          color: Colors.white),
      subtitle1: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Adaptive.dp(15),
          fontWeight: FontWeight.w300,
          color: Colors.white),
      subtitle2: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Adaptive.dp(12),
          fontWeight: FontWeight.w300,
          color: Colors.white),
      bodyText1: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Adaptive.dp(15),
          fontWeight: FontWeight.w500,
          color: Colors.white),
      bodyText2: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Adaptive.dp(12),
          fontWeight: FontWeight.w500,
          color: Colors.grey),
      button: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Adaptive.dp(15),
          fontWeight: FontWeight.w700,
          color: Colors.black)),
  // textTheme:
);

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
