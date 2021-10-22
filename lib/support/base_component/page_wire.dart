import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class PageWire extends StatelessWidget {
  PageWire({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    Adaptive.w(100) > 475 ? 475 / 100 * 5 : Adaptive.w(5)),
            child: child));
  }
}

class LeftPageWire extends StatelessWidget {
  LeftPageWire({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.only(
                left: Adaptive.w(100) > 475 ? 475 / 100 * 5 : Adaptive.w(5)),
            child: child));
  }
}
