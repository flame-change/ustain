import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/account/view/finding_password_page.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/orderForm/view/orderForm_list_screen.dart';
import 'package:aroundus_app/modules/mypage/address/view/address_screen.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/modules/store/coupon/view/coupon_screen.dart';
import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/support/base_component/company_info.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:aroundus_app/support/base_component/page_wire.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
  late User user;
  late bool is_authenticated;
  PackageInfo _packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown');

  @override
  void initState() {
    super.initState();
    user = context.read<AuthenticationBloc>().state.user;
    is_authenticated = context.read<AuthenticationBloc>().state.status ==
        AuthenticationStatus.authenticated;
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      PageWire(
          child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text('My Page',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500)))),
      if (is_authenticated) myPageInfo() else loginNeededProfile(),
      Container(
          color: Colors.white,
          child: Column(children: [
            SizedBox(height: 20),
            shoppingWire(context),
            SizedBox(height: 20),
            helpcenterWire(context),
            SizedBox(height: 20),
            helpcenterWire2(context),
            SizedBox(height: Adaptive.h(5)),
            if (is_authenticated) logOutMethod(context),
            if (is_authenticated) SizedBox(height: Adaptive.h(5)),
            CompanyInfo()
          ]))
    ]);
  }

  Row logOutMethod(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      MaterialButton(
          padding: EdgeInsets.all(10),
          onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(title: Text("로그아웃 하시겠습니까?"), actions: [
                  MaterialButton(
                      onPressed: () =>
                          RepositoryProvider.of<AuthenticationRepository>(
                                  context)
                              .logOut(),
                      child: Text("확인"))
                ]);
              }),
          child: Text('로그아웃',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.grey, decoration: TextDecoration.underline))),
      Container(
          height: 12,
          width: 1,
          color: Colors.grey,
          margin: EdgeInsets.symmetric(horizontal: 30)),
      MaterialButton(
          padding: EdgeInsets.all(10),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(title: Text("회원 탈퇴 하시겠습니까?"), actions: [
                    MaterialButton(
                        onPressed: () {
                          RepositoryProvider.of<AuthenticationRepository>(
                                  context)
                              .signOut();
                        },
                        child: Text("확인"))
                  ]);
                });
          },
          child: Text('회원탈퇴',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.grey, decoration: TextDecoration.underline)))
    ]);
  }

  Column helpcenterWire(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      menuWidget('Account'),
      SizedBox(height: 10),
      PageWire(
          child: Column(children: [
        subMenuWidget(
            title: "비밀번호 수정",
            tapped: () {
              is_authenticated == true
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BlocProvider<FindingAccountCubit>(
                              create: (context) => FindingAccountCubit(
                                  RepositoryProvider.of<
                                      AuthenticationRepository>(context)),
                              child: FindingPasswordPage())))
                  : showLoginNeededDialog(context);
            }),
        subMenuWidget(
            title: "1:1 문의하기",
            tapped: () {
              requestCameraPermission(context);
            })
      ]))
    ]);
  }

  Column helpcenterWire2(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      menuWidget('Service'),
      SizedBox(height: 10),
      PageWire(
          child: Column(children: [
        subMenuWidget(
            title: "개인정보 처리방침",
            tapped: () =>
                isWebRouter(context, 'https://aroundusprivacypolicy.oopy.io/')),
        subMenuWidget(
            title: "서비스 이용약관",
            tapped: () => isWebRouter(context, 'https://arounduspp2.oopy.io/')),
        subMenuWidget(
            title: "개인정보 수집, 이용 방침",
            tapped: () =>
                isWebRouter(context, 'https://aroundusprivacypolicy.oopy.io/')),
        ListTile(
            contentPadding: EdgeInsets.all(0),
            dense: true,
            leading: Text('버전 정보',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black, fontSize: Adaptive.dp(14))),
            trailing: Text('${_packageInfo.version}',
                style: TextStyle(color: Colors.black)))
      ]))
    ]);
  }

  Column shoppingWire(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      menuWidget('Shopping'),
      SizedBox(height: 10),
      PageWire(
          child: Column(children: [
        subMenuWidget(
            title: "내 쿠폰",
            tapped: () {
              if (is_authenticated) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CouponScreen(isMypage: true)));
              } else {
                showLoginNeededDialog(context);
              }
            }),
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
            title: "주문 내역",
            tapped: () {
              if (is_authenticated) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => OrderFormListScreen()));
              } else {
                showLoginNeededDialog(context);
              }
            })
      ]))
    ]);
  }

  Widget myPageInfo() {
    return Container(
        color: Colors.black,
        child: PageWire(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(height: 15),
              Row(children: [
                Text("Lv.${user.group![0]['level']} ${user.name}",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white)),
                SizedBox(
                    height: Adaptive.dp(30),
                    width: Adaptive.dp(20),
                    child: IconButton(
                        padding: EdgeInsets.only(bottom: Adaptive.dp(12)),
                        onPressed: () => showTopSnackBar(
                            context,
                            CustomSnackBar.info(
                                message:
                                    "회원 등급은 매월 1일, \n이전 달의 기록에 따라 정해집니다. :)")),
                        iconSize: Adaptive.dp(12),
                        icon: Icon(Icons.info),
                        color: Colors.grey))
              ]),
              Container(
                  height: 3,
                  margin: EdgeInsets.only(top: 10, bottom: 15),
                  color: HexColor("${user.group![0]['hexCode']}")),
              userCategories(),
              SizedBox(height: 15)
            ])));
  }

  RichText userCategories() {
    return RichText(
        text: TextSpan(children: [
      for (var category in user.selectedCategories!)
        WidgetSpan(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                margin: EdgeInsets.only(right: 5, bottom: 3),
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

  Future<bool> requestCameraPermission(BuildContext context) async {
    PermissionStatus status = await Permission.camera.request();

    if (!status.isGranted) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(content: Text("권한 설정을 확인해주세요."), actions: [
              FlatButton(
                  onPressed: () => openAppSettings(), child: Text('설정하기'))
            ]);
          });
      return false;
    } else {
      isWebRouter(context, 'https://ed83p.channel.io');
      return true;
    }
  }
}

class loginNeededProfile extends StatelessWidget {
  const loginNeededProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWire(
        child: Container(
            height: 175,
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, color: Colors.white),
                  SizedBox(height: 10),
                  Text('로그인이 필요한 서비스입니다.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white)),
                  SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizeWidth(5), vertical: 10),
                      child: MaterialButton(
                          minWidth: sizeWidth(90),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text('Login / Register',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white)),
                          color: Colors.black,
                          onPressed: () =>
                              RepositoryProvider.of<AuthenticationRepository>(
                                      context)
                                  .logOut()))
                ])));
  }
}
