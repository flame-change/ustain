import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class TitleWithUnderline extends StatelessWidget {
  const TitleWithUnderline(
      {required this.title, required this.subtitle, this.color = Colors.white});

  final String? title;
  final String? subtitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            Container(
                margin: EdgeInsets.only(
                    top: theme.textTheme.headline5!.fontSize! / 2 + 2),
                height: 5,
                color: Colors.black,
                width: double.maxFinite),
            Container(
                color: color,
                child: Text("${title}  ",
                    style: theme.textTheme.headline5!
                        .copyWith(letterSpacing: -0.5)))
          ]),
          SizedBox(height: 3),
          Container(
              color: color,
              child: Text('${subtitle}', style: theme.textTheme.subtitle2))
        ]));
  }
}
