import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/mypage/view/components/user_profile_divider.dart';
import 'package:aroundus_app/modules/mypage/view/components/user_profile_info.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:aroundus_app/support/base_component/page_wire.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'components/menu_widgets.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late AuthenticationRepository _authenticationRepository;
  late User user;

  @override
  void initState() {
    super.initState();
    _authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    user = context.read<AuthenticationBloc>().state.user;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      if (context.read<AuthenticationBloc>().state.status ==
          AuthenticationStatus.authenticated)
        Container(
            height: Adaptive.h(15), color: Colors.black, child: myPageInfo())
      else
        Padding(
            padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
            child: LoginNeeded()),
      if (context.read<AuthenticationBloc>().state.status ==
          AuthenticationStatus.authenticated)
        Container(
            height: Adaptive.h(10),
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
            child: orderInfo()),
      Container(
          padding: EdgeInsets.all(Adaptive.w(5)),
          child: Column(children: [
            menuWidget("SHOPPING"),
            subMenuWidget(title: "배송지 관리"),
            subMenuWidget(title: "주문 / 취소내역"),
            subMenuWidget(title: "내 리뷰")
          ])),
      Container(
          padding: EdgeInsets.all(Adaptive.w(5)),
          child: Column(children: [
            menuWidget("HELP CENTER"),
            subMenuWidget(title: "1:1 문의하기", taped: () {}),
            subMenuWidget(title: "FAQ"),
            subMenuWidget(title: "공지사항")
          ])),
      SizedBox(height: Adaptive.h(5)),
      if (context.read<AuthenticationBloc>().state.status ==
          AuthenticationStatus.authenticated)
        GestureDetector(
            onTap: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(title: Text("로그아웃 하시겠습니까?"), actions: [
                    MaterialButton(
                        onPressed: () => _authenticationRepository.logOut(),
                        child: Text("확인"))
                  ]);
                }),
            child: Center(
                child: Text('로그아웃',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.grey,
                        decoration: TextDecoration.underline)))),
      if (context.read<AuthenticationBloc>().state.status ==
          AuthenticationStatus.authenticated)
        SizedBox(height: Adaptive.h(10))
    ]));
  }

  Widget myPageInfo() {
    return PageWire(
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: Adaptive.w(13),
          height: Adaptive.w(13),
          margin: EdgeInsets.only(right: Adaptive.w(5)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: theme.accentColor)),
      RichText(
          text: TextSpan(style: theme.textTheme.headline4, children: [
        TextSpan(text: "${user.name} ", style: TextStyle(color: Colors.white)),
        TextSpan(
            text: "\nLV5. 채식맨 ",
            style: theme.textTheme.bodyText2!
                .copyWith(height: 1.5, color: Color(0xFF979797))),
        WidgetSpan(
            child: Padding(
                padding: EdgeInsets.only(bottom: Adaptive.h(1.3)),
                child: Icon(Icons.info,
                    size: Adaptive.dp(10), color: Colors.grey)))
      ]))
    ]));
  }

  Widget orderInfo() {
    return Row(children: [
      UserProfileInfo(context: context, count: 3, title: '쿠폰', onTap: () {}),
      UserVerticalDivider(),
      UserProfileInfo(context: context, count: 4, title: '후기 작성', onTap: () {}),
      UserVerticalDivider(),
      UserProfileInfo(context: context, count: 4, title: '내 성과', onTap: () {})
    ]);
  }
}
