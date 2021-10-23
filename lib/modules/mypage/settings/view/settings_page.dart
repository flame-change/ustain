import 'package:aroundus_app/modules/mypage/view/components//menu_widgets.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            menuWidget("SERVICE"),
            subMenuWidget(title: "개인정보 처리방침"),
            subMenuWidget(title: "서비스 이용약관")
          ])),
      Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            menuWidget("NOTIFICATIONS"),
            subMenuWidget(title: "카카오톡 알림 설정"),
            subMenuWidget(title: "푸시 알림 설정")
          ])),
      Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            menuWidget("ETC."),
            subMenuWidget(title: "버전 정보"),
          ])),
      Padding(
          padding: EdgeInsets.all(20),
          child: Text('회원 탈퇴',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.grey, decoration: TextDecoration.underline)))
    ]);
  }
}
