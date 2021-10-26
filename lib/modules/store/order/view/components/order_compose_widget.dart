import 'package:aroundus_app/support/base_component/blank_widget.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';

Widget orderCompose({String? title, Widget? child}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("$title", style: theme.textTheme.headline4),
    Blank(height: 6, color: Colors.black),
    child != null ? child : SizedBox(height: 0),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Divider(color: Colors.grey),
    )
  ]);
}
