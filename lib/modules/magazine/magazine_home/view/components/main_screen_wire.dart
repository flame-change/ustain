import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';

class MainScreenWire extends StatelessWidget {
  const MainScreenWire(
      {required this.page1Title,
      required this.page2Ttile,
      required this.action,
      required this.indicatorWidth,
      required this.firstPage,
      required this.secondPage,
      this.brightness = Brightness.light,
      this.appBarBackgroundColor = Colors.white});

  final Widget page1Title;
  final Widget page2Ttile;
  final double indicatorWidth;
  final Widget action;
  final Widget firstPage;
  final Widget secondPage;
  final Brightness brightness;
  final Color appBarBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              brightness: brightness,
              backgroundColor: appBarBackgroundColor,
              elevation: 0,
              title: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: TabBar(
                          isScrollable: true,
                          tabs: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: page1Title),
                            Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: page2Ttile)
                          ],
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  width: indicatorWidth,
                                  color: theme.accentColor),
                              insets: EdgeInsets.only(bottom: -6)),
                          labelStyle: theme.textTheme.button!
                              .copyWith(fontSize: Adaptive.dp(20)),
                          labelColor: Colors.black,
                          labelPadding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.only(right: 20)))),
              actions: [action]),
          body: TabBarView(children: [firstPage, secondPage]),
        ));
  }
}
