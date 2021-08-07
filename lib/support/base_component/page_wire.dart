import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PageWire extends StatelessWidget {

  PageWire({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: child));
  }
}