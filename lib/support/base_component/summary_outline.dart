import 'package:flutter/material.dart';

Widget summaryOutline({
  required String title,
  required String content,
  TextStyle? titleStyle,
  TextStyle? contentStyle,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "$title",
        style: titleStyle,
      ),
      Text("$content", style: contentStyle)
    ],
  );
}
