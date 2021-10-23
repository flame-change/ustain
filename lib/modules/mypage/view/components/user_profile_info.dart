import 'package:flutter/material.dart';

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo(
      {Key? key,
      required this.context,
      required this.count,
      required this.title})
      : super(key: key);

  final BuildContext context;
  final int count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Text('$count', style: Theme.of(context).textTheme.headline4),
          SizedBox(height: 10),
          Text('$title',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400))
        ]));
  }
}
