import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/page_wire.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPage extends StatefulWidget {
  static String routeName = 'mypage_page';

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
      height: Adaptive.h(100),
      child: Column(
        children: [
          Container(
              height: Adaptive.h(30),
              padding: EdgeInsets.symmetric(vertical: 30),
              color: Colors.black,
              child: myPageInfo()),
          Container(
            height: Adaptive.h(10),
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
            child: orderInfo(),
          ),
          Expanded(
            child: Container(
              padding: basePadding(vertical: 30),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        menuWidget("SHOPPING"),
                        subMenuWidget(
                            title: "배송지 관리",
                            taped: () {
                              print("배송지");
                            }),
                        subMenuWidget(title: "취소 / 교환 / 반품 내역"),
                        subMenuWidget(title: "내 리뷰"),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        menuWidget("HELP CENTER"),
                        subMenuWidget(
                            title: "1:1 문의하기",
                            taped: () {
                            }),
                        subMenuWidget(title: "FAQ"),
                        subMenuWidget(title: "공지사항"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget myPageInfo() {
    return PageWire(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "PROFILE",
                style: theme.textTheme.headline3!.copyWith(color: Colors.white),
              ),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/icons/settings.svg',
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: theme.accentColor
                    // image: Image.network(user.)
                    ),
              ),
              RichText(
                text: TextSpan(
                    style: theme.textTheme.headline4!.copyWith(height: 1.5),
                    children: [
                      TextSpan(
                        text: "${user.name}\n",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                          text: "LV5. 채식맨",
                          style: theme.textTheme.bodyText2!
                              .copyWith(color: Color(0xFF979797))),
                    ]),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget orderInfo() {
    return Row();
  }

  Widget menuWidget(title) {
    return Container(
      width: Adaptive.w(100),
      padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 3))),
      child: Text(
        "$title",
        style: theme.textTheme.headline3!.copyWith(
          fontSize: Adaptive.dp(20),
        ),
      ),
    );
  }

  Widget subMenuWidget({String? title, Function()? taped}) {
    return GestureDetector(
      onTap: taped,
      child: Container(
        width: Adaptive.w(100),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
        child: Text(
          "$title",
          style: theme.textTheme.subtitle1!
              .copyWith(fontWeight: FontWeight.w400, fontSize: Adaptive.dp(18)),
        ),
      ),
    );
  }
}
