import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class AchievementTile extends StatelessWidget {
  AchievementTile(
      {@required this.name,
      @required this.child,
      @required this.description,
      @required this.value});

  final String? name, description;
  final Widget? child;
  final int? value;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () {},
            leading: child,
            title: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: '${name}', style: Theme.of(context).textTheme.headline5)
            ])),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${description}'),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 5,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                            value: value! / 3, backgroundColor: Colors.grey))),
              ],
            ),
            trailing: Padding(
              padding: EdgeInsets.only(top: Adaptive.h(1)),
              child: Text('${value} / 3',
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            isThreeLine: true));
  }
}
