import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class TitleWithUnderline extends StatelessWidget {
  const TitleWithUnderline({required this.title, required this.subtitle});

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(overflow: Overflow.visible, children: [
        Positioned(
            top: 14,
            left: 0,
            right: 0,
            child: Container(height: 18, color: theme.accentColor)),
        Padding(
          padding: EdgeInsets.only(left: 3, right: 3, bottom: 3),
          child: Text("${title}",
              style: theme.textTheme.headline4!.copyWith(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
        )
      ]),
      SizedBox(height: Adaptive.h(0.3)),
      Text('${subtitle}', style: theme.textTheme.subtitle2)
    ]);
  }
}
