import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';

Widget orderFormBaseComponent({String? title, List<Widget>? children, bool? isExpansion=false}) {
  return Theme(
    data: theme.copyWith(dividerColor: Colors.transparent),
    child: Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 6))),
      child: ExpansionTile(
        title: Text("$title", style: theme.textTheme.headline4),
        // Blank(height: 6, color: Colors.black),
        children: children!,
        childrenPadding: EdgeInsets.only(bottom: 10),
        tilePadding: EdgeInsets.zero,
        initiallyExpanded: isExpansion!,
      ),
    ),
  );
}
