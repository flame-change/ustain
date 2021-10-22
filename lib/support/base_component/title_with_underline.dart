import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class TitleWithUnderline extends StatelessWidget {
  const TitleWithUnderline({required this.title, required this.subtitle});

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      WidgetSpan(
          child: Stack(overflow: Overflow.visible, children: [
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(height: 20, color: theme.accentColor)),
        Text("${title}",
            style: theme.textTheme.headline3!.copyWith(height: 1.5))
      ])),
      WidgetSpan(child: Text('${subtitle}', style: theme.textTheme.subtitle1))
    ]));
  }
}
