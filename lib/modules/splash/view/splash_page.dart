import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  static String routeName = '/';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("SplashPage"),
      ),
    );
  }
}