import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class PlainButton extends StatefulWidget {
  PlainButton({
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.borderColor,
  });

  final String text;
  final int? width;
  final double? height;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback? onPressed;

  @override
  _PlainButtonState createState() => _PlainButtonState();
}

class _PlainButtonState extends State<PlainButton> {
  String get text => this.widget.text;

  int? get width => this.widget.width == null ? 100 : this.widget.width;

  double? get height => this.widget.height == null ? 6 : this.widget.height;

  Color? get color =>
      this.widget.color == null ? Colors.black : this.widget.color;

  Color? get borderColor =>
      this.widget.borderColor == null ? null : this.widget.borderColor;

  Color? get textColor =>
      this.widget.textColor == null ? Colors.white : this.widget.textColor;

  VoidCallback? get _onPressed => this.widget.onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeWith(width!),
      // color: color,
      decoration: BoxDecoration(
          color: color,
          border:
              Border.all(color: borderColor == null ? color! : borderColor!)),
      height: Adaptive.h(height!),
      child: _onPressed == null
          ? Align(
        alignment: Alignment.center,
            child: Text(
                text,
                style: theme.textTheme.button!.copyWith(color: textColor),
              ),
          )
          : MaterialButton(
              onPressed: _onPressed,
              textColor: borderColor == null ? textColor : borderColor,
              elevation: 0,
              child: Text(text),
            ),
    );
  }
}
