import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../login_home.dart';

class LoginHomeScreen extends StatefulWidget {
  static String routeName = '/login_home_screen';

  LoginHomeScreen({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginHomeScreen());
  }

  @override
  State<LoginHomeScreen> createState() => _LoginHomeScreen();
}

class _LoginHomeScreen extends State<LoginHomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(backgroundColor: Colors.black, body: LoginHomePage());
  }
}
