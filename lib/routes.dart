import 'package:aroundus_app/modules/authentication/account/view/finding_password_request_page.dart';
import 'package:aroundus_app/modules/main/main_screen.dart';
import 'package:aroundus_app/modules/mypage/user_profile/view/user_profile_screen.dart';
import 'package:aroundus_app/modules/store/store_home/view/store_home_screen.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/magazine_home.dart';
import 'package:aroundus_app/modules/mypage/settings/view/settings_screen.dart';
import 'package:aroundus_app/modules/store/cart/view/cart_screen.dart';
import 'modules/authentication/login_home/view/view.dart';
import 'package:aroundus_app/modules/mypage/mypage.dart';
import 'modules/authentication/account/view/view.dart';
import 'modules/authentication/signup/view/view.dart';
import 'package:aroundus_app/modules/home/home.dart';
import 'package:flutter/widgets.dart';
import 'modules/splash/splash.dart';

final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  MainScreen.routeName: (context) => MainScreen(),
  LoginHomeScreen.routeName: (context) => LoginHomeScreen(),
  PhoneVerifyPage.routeName: (context) => PhoneVerifyPage(),
  HomeScreen.routeName: (context) => HomeScreen(),
  SignupForm.routeName: (context) => SignupForm(),
  MagazineHomeScreen.routeName: (context) => MagazineHomeScreen(),
  MagazineHomePage.routeName: (context) => MagazineHomePage(),
  FindingPasswordPage.routeName: (context) => FindingPasswordPage(),
  FindingPasswordRequestPage.routeName: (context) =>
      FindingPasswordRequestPage(),
  SignupNicknamePage.routeName: (context) => SignupNicknamePage(),
  StoreHomeScreen.routeName: (context) => StoreHomeScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  MyPageScreen.routeName: (context) => MyPageScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
  UserProfileScreen.routeName: (context) => UserProfileScreen(),
};

Route routePage(Widget nextPage) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      });
}
