import 'package:aroundus_app/modules/mypage/achievements/view/achievement_screen.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/mypage/view/components/user_profile_divider.dart';
import 'package:aroundus_app/modules/mypage/view/components/user_profile_info.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/mypage/external_link/external_link.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/company_info.dart';
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
  late bool is_authenticated;

  @override
  void initState() {
    super.initState();
    _authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    user = context.read<AuthenticationBloc>().state.user;
    if (context.read<AuthenticationBloc>().state.status ==
        AuthenticationStatus.authenticated) {}
    is_authenticated = context.read<AuthenticationBloc>().state.status ==
        AuthenticationStatus.authenticated;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(children: [
          if (is_authenticated)
            Container(
                height: Adaptive.h(15),
                color: Colors.black,
                child: myPageInfo())
          else
            PageWire(child: LoginNeeded()),
          if (is_authenticated)
            Container(
                height: Adaptive.h(10),
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
                child: orderInfo()),
          SizedBox(height: Adaptive.w(5)),
          PageWire(
              child: Column(children: [
            menuWidget("SHOPPING"),
            subMenuWidget(
                title: "배송지 관리",
                tapped: () {
                  is_authenticated ? null : showLoginNeededDialog(context);
                }),
            subMenuWidget(
                title: "주문 / 취소내역",
                tapped: () {
                  is_authenticated ? null : showLoginNeededDialog(context);
                }),
            subMenuWidget(
                title: "내 리뷰",
                tapped: () {
                  is_authenticated ? null : showLoginNeededDialog(context);
                })
          ])),
          SizedBox(height: Adaptive.w(5)),
          PageWire(
              child: Column(children: [
            menuWidget("HELP CENTER"),
            subMenuWidget(
                title: "1:1 문의하기",
                tapped: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            ExternalLink(url: 'https://ed83p.channel.io/')))),
            subMenuWidget(
                title: "FAQ",
                tapped: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ExternalLink(
                            url:
                                'https://rhinestone-gladiolus-89e.notion.site/FAQ-444b0a8fd5104a5b858ffbfd33c1f516')))),
            subMenuWidget(
                title: "공지사항",
                tapped: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ExternalLink(
                            url:
                                'https://rhinestone-gladiolus-89e.notion.site/d6afc3caa00b48cfa1cd7d4773bec558'))))
          ])),
          SizedBox(height: Adaptive.h(5)),
          if (is_authenticated)
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
          if (is_authenticated) SizedBox(height: Adaptive.h(5)),
          CompanyInfo()
        ]));
  }

  Widget myPageInfo() {
    return PageWire(
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: Adaptive.w(13),
          height: Adaptive.w(13),
          margin: EdgeInsets.only(right: Adaptive.w(5)),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: theme.accentColor)),
      RichText(
          text: TextSpan(style: theme.textTheme.headline4, children: [
        TextSpan(text: "${user.name} ", style: TextStyle(color: Colors.white)),
        TextSpan(
            text: "\nLV5. 채식맨 ",
            style: theme.textTheme.bodyText2!
                .copyWith(height: 1.5, color: Color(0xFF979797))),
        WidgetSpan(
            child: SizedBox(
                height: Adaptive.dp(18),
                width: Adaptive.dp(10),
                child: IconButton(
                    padding: EdgeInsets.only(bottom: Adaptive.dp(10)),
                    onPressed: () => _authenticationRepository.signOut(),
                    iconSize: Adaptive.dp(10),
                    icon: Icon(Icons.info),
                    color: Colors.grey)))
      ]))
    ]));
  }

  Widget orderInfo() {
    return Row(children: [
      UserProfileInfo(context: context, count: 3, title: '쿠폰', onTap: () {}),
      UserVerticalDivider(),
      UserProfileInfo(context: context, count: 4, title: '후기 작성', onTap: () {}),
      UserVerticalDivider(),
      UserProfileInfo(
          context: context,
          count: 4,
          title: '기록',
          onTap: () =>
              Navigator.pushNamed(context, AchievementScreen.routeName))
    ]);
  }
}
