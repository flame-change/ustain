import 'package:flutter/material.dart';

class UserVerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: Colors.black,
      thickness: 1,
      indent: 20,
      endIndent: 20,
      width: 0,
    );
  }
}
