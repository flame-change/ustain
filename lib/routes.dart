
import 'package:aroundus_app/modules/home/home.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/magazine_home.dart';
import 'package:aroundus_app/modules/store/store_home/view/store_home_page.dart';
import 'package:aroundus_app/modules/store/store_home/view/store_home_screen.dart';
import 'package:flutter/widgets.dart';

import 'modules/authentication/account/view/view.dart';
import 'modules/authentication/login_home/view/view.dart';
import 'modules/authentication/signup/view/view.dart';
import 'modules/splash/splash.dart';


final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  LoginHomeScreen.routeName: (context) => LoginHomeScreen(),
  PhoneVerifyPage.routeName: (context) => PhoneVerifyPage(),
  HomeScreen.routeName: (context) => HomeScreen(),
  SignupForm.routeName: (context) => SignupForm(),
  MagazineHomeScreen.routeName: (context) => MagazineHomeScreen(),
  MagazineHomePage.routeName: (context) => MagazineHomePage(),
  FindingPasswordPage.routeName: (context) => FindingPasswordPage(),
  SignupNicknamePage.routeName: (context) => SignupNicknamePage(),
  StoreHomeScreen.routeName: (context) => StoreHomeScreen(),
  StorePage.routeName: (context) => StorePage(),
};

Route routePage(Widget nextPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => nextPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0,0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}