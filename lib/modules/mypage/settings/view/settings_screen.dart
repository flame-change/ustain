import 'package:aroundus_app/modules/mypage/settings/view/settings_page.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = '/settings_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SettingsScreen());
  }

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
                onPressed: () => Navigator.of(context).pop())),
        body: SingleChildScrollView(child: PageWire(child: SettingsPage())));
  }
}
