import 'package:aroundus_app/modules/mypage/update_profile/view/update_profile_screen.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/mypage/view/components/user_profile_divider.dart';
import 'package:aroundus_app/modules/mypage/view/components/user_profile_info.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/mypage/user_info/view/user_info_screen.dart';
import 'package:aroundus_app/modules/orderForm/view/orderForm_list_screen.dart';
import 'package:aroundus_app/modules/mypage/address/view/address_screen.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/support/base_component/company_info.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:aroundus_app/support/base_component/page_wire.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
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
          SizedBox(height: sizeWidth(5)),
          shoppingWire(context),
          SizedBox(height: sizeWidth(5)),
          helpcenterWire(context),
          SizedBox(height: sizeWidth(5)),
          personalinfoWire(),
          SizedBox(height: Adaptive.h(5)),
          if (is_authenticated) logoutMethod(context),
          if (is_authenticated) SizedBox(height: Adaptive.h(5)),
          CompanyInfo()
        ]));
  }

  GestureDetector logoutMethod(BuildContext context) {
    return GestureDetector(
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
                    decoration: TextDecoration.underline))));
  }

  PageWire personalinfoWire() {
    return PageWire(
        child: Container(
            child: Column(children: [
      menuWidget("PERSONAL INFO"),
      subMenuWidget(
          title: '개인정보 수정',
          tapped: () => is_authenticated == true
              ? Navigator.pushNamed(context, UpdateProfileScreen.routeName)
              : showLoginNeededDialog(context)),
      subMenuWidget(title: "비밀번호 수정", tapped: () {})
    ])));
  }

  PageWire helpcenterWire(BuildContext context) {
    return PageWire(
        child: Column(children: [
      menuWidget("HELP CENTER"),
      subMenuWidget(
          title: "1:1 문의하기",
          tapped: () => isWebRouter(context, 'https://ed83p.channel.io/')),
      subMenuWidget(
          title: "FAQ",
          tapped: () => isWebRouter(context,
              'https://rhinestone-gladiolus-89e.notion.site/FAQ-444b0a8fd5104a5b858ffbfd33c1f516')),
      subMenuWidget(
          title: "공지사항",
          tapped: () => isWebRouter(context,
              'https://rhinestone-gladiolus-89e.notion.site/d6afc3caa00b48cfa1cd7d4773bec558'))
    ]));
  }

  PageWire shoppingWire(BuildContext context) {
    return PageWire(
        child: Column(children: [
      menuWidget("SHOPPING"),
      subMenuWidget(
          title: "배송지 관리",
          tapped: () {
            if (is_authenticated) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AddressScreen(isOrdering: false)));
            } else {
              showLoginNeededDialog(context);
            }
          }),
      subMenuWidget(
          title: "주문 / 취소내역",
          tapped: () {
            if (is_authenticated) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OrderFormListScreen()));
            } else {
              showLoginNeededDialog(context);
            }
          }),
      subMenuWidget(
          title: "내 리뷰",
          tapped: () {
            is_authenticated ? null : showLoginNeededDialog(context);
          })
    ]));
  }

  Widget myPageInfo() {
    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, UserInfoScreen.routeName),
        child: PageWire(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              width: sizeWidth(13),
              height: sizeWidth(13),
              margin: EdgeInsets.only(right: sizeWidth(5)),
              child: CircleAvatar(
                  backgroundColor: HexColor("${user.group![0]['hexCode']}"),
                  backgroundImage: AssetImage('assets/images/ut-face.png')),
              decoration: BoxDecoration(shape: BoxShape.circle)),
          Flexible(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children: [
                  Text("Lv.${user.group![0]['level']} ${user.name}",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white)),
                  SizedBox(
                      height: Adaptive.dp(18),
                      width: Adaptive.dp(10),
                      child: IconButton(
                          padding: EdgeInsets.only(
                              left: Adaptive.dp(3), bottom: Adaptive.dp(10)),
                          onPressed: () => showTopSnackBar(
                              context,
                              CustomSnackBar.info(
                                  message:
                                      "회원 등급은 매월 1일, \n이전 달의 기록에 따라 정해집니다. :)")),
                          iconSize: Adaptive.dp(10),
                          icon: Icon(Icons.info),
                          color: Colors.grey))
                ]),
                SizedBox(height: Adaptive.h(1)),
                userCategories()
              ]))
        ])));
  }

  RichText userCategories() {
    return RichText(
        text: TextSpan(children: [
      for (var category in user.selectedCategories!)
        WidgetSpan(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(sizeWidth(5))),
                child: Text(category.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white))))
    ]));
  }

  Widget orderInfo() {
    return Row(children: [
      UserProfileInfo(context: context, count: 3, title: '쿠폰', onTap: () {}),
      UserVerticalDivider(),
      UserProfileInfo(context: context, count: 4, title: '후기 작성', onTap: () {})
    ]);
  }
}
