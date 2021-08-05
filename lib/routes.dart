
import 'package:flutter/widgets.dart';

import 'models/home/home.dart';
import 'models/splash/splash.dart';


final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  HomeScreen.routeName: (context) => HomeScreen(),
};