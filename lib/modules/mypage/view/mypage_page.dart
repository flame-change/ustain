import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/mypage/user_profile/view/user_profile_screen.dart';
import 'package:aroundus_app/modules/mypage/view/components/user_profile_divider.dart';
import 'package:aroundus_app/modules/mypage/view/components/user_profile_info.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
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
        height: Adaptive.h(90),
        child: Column(children: [
          Container(
              height: Adaptive.h(15),
              padding: EdgeInsets.symmetric(vertical: 30),
              color: Colors.black,
              child: myPageInfo()),
          Container(
              height: Adaptive.h(10),
              decoration:
                  BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
              child: orderInfo()),
          Container(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                menuWidget("SHOPPING"),
                subMenuWidget(title: "배송지 관리"),
                subMenuWidget(title: "취소 / 교환 / 반품 내역"),
                subMenuWidget(title: "내 리뷰")
              ])),
          Container(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                menuWidget("HELP CENTER"),
                subMenuWidget(title: "1:1 문의하기", taped: () {}),
                subMenuWidget(title: "FAQ"),
                subMenuWidget(title: "공지사항")
              ])),
          SizedBox(height: Adaptive.h(5)),
          GestureDetector(
              onTap: () {},
              child: Center(
                  child: Text('로그아웃',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.grey,
                          decoration: TextDecoration.underline))))
        ]));
  }

  Widget myPageInfo() {
    return PageWire(
        child: GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, UserProfileScreen.routeName),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: theme.accentColor)),
              RichText(
                  text: TextSpan(style: theme.textTheme.headline4, children: [
                TextSpan(
                    text: "${user.name} ",
                    style: TextStyle(color: Colors.white)),
                WidgetSpan(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Icon(Icons.arrow_forward_ios_rounded,
                            size: 20, color: Colors.white))),
                TextSpan(
                    text: "\nLV5. 채식맨",
                    style: theme.textTheme.bodyText2!
                        .copyWith(height: 1.5, color: Color(0xFF979797)))
              ]))
            ])));
  }

  Widget orderInfo() {
    return Row(children: [
      UserProfileInfo(context: context, count: 4, title: '주문 내역'),
      UserVerticalDivider(),
      UserProfileInfo(context: context, count: 4, title: '주문 내역'),
      UserVerticalDivider(),
      UserProfileInfo(context: context, count: 4, title: '주문 내역'),
      UserVerticalDivider(),
      UserProfileInfo(context: context, count: 4, title: '주문 내역')
    ]);
  }
}
