import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/mypage/view/components//menu_widgets.dart';
import 'package:aroundus_app/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late User user;
  late bool is_authenticated;

  @override
  void initState() {
    super.initState();
    user = context.read<AuthenticationBloc>().state.user;
    is_authenticated = context.read<AuthenticationBloc>().state.status ==
        AuthenticationStatus.authenticated;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.all(Adaptive.w(5)),
          child: Column(children: [
            menuWidget("ACCOUNT"),
            subMenuWidget(
                title: "닉네임 수정",
                tapped: () {
                  is_authenticated ? null : showLoginNeededDialog(context);
                }),
            subMenuWidget(
                title: "휴대폰 번호 수정",
                tapped: () {
                  is_authenticated ? null : showLoginNeededDialog(context);
                })
          ])),
      Container(
          padding: EdgeInsets.all(Adaptive.w(5)),
          child: Column(children: [
            menuWidget("SERVICE"),
            subMenuWidget(title: "개인정보 처리방침"),
            subMenuWidget(title: "서비스 이용약관")
          ])),
      Container(
          padding: EdgeInsets.all(Adaptive.w(5)),
          child: Column(children: [
            menuWidget("ETC."),
            subMenuWidget(title: "버전 정보"),
          ])),
      if (is_authenticated)
        GestureDetector(
            onTap: () {},
            child: Padding(
                padding: EdgeInsets.all(Adaptive.w(5)),
                child: Text('회원 탈퇴',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.grey,
                        decoration: TextDecoration.underline))))
    ]);
  }
}
