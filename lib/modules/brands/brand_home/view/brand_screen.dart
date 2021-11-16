import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter/material.dart';

import '../components/body.dart';

class BrandScreen extends StatefulWidget {
  static String routeName = 'brand_screen';

  @override
  _BrandScreenState createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text('브랜드', style: Theme.of(context).textTheme.headline4),
          actions: [
            GestureDetector(
                // onTap: () => Navigator.pushNamed(
                //     context, SettingsScreen.routeNameName),
                child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.search, color: Colors.black)))
          ]),
      body: Body(),
    );
  }
}
