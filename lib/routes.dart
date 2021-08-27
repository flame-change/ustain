
import 'package:aroundus_app/modules/home/home.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/magazine_home.dart';
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
  FindingEmailPage.routeName: (context) => FindingEmailPage(),

};