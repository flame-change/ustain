import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter/material.dart';

class PageWire extends StatelessWidget {
  PageWire({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeWidth(5)),
            child: child));
  }
}

class LeftPageWire extends StatelessWidget {
  LeftPageWire({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: sizeWidth(5)),
            child: child));
  }
}
