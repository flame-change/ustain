
import 'package:flutter/widgets.dart';

import 'modules/authentication/login_home/view/view.dart';
import 'modules/splash/splash.dart';





final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  LoginHomeScreen.routeName: (context) => LoginHomeScreen(),
};