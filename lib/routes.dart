import 'package:aroundus_app/modules/search/search_result/view/search_result_screen.dart';
import 'package:aroundus_app/modules/brands/brand_detail/view/brand_detail_screen.dart';
import 'package:aroundus_app/modules/store/store_home/view/store_home_screen.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/magazine_home.dart';
import 'package:aroundus_app/modules/store/order/view/order_cancel_page.dart';
import 'package:aroundus_app/modules/search/search/view/search_screen.dart';
import 'package:aroundus_app/modules/store/coupon/view/coupon_screen.dart';
import 'package:aroundus_app/modules/store/cart/view/cart_screen.dart';
import 'modules/mypage/user_info/view/user_info_screen.dart';
import 'package:aroundus_app/modules/main/main_screen.dart';
import 'modules/brands/brand_home/view/brand_screen.dart';
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
  HomeScreen.routeName: (context) => HomeScreen(),
  SignupForm.routeName: (context) => SignupForm(),
  CartScreen.routeName: (context) => CartScreen(),
  BrandScreen.routeName: (context) => BrandScreen(),
  CouponScreen.routeName: (context) => CouponScreen(),
  MyPageScreen.routeName: (context) => MyPageScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  UserInfoScreen.routeName: (context) => UserInfoScreen(),
  OrderCancelPage.routeName: (context) => OrderCancelPage(),
  StoreHomeScreen.routeName: (context) => StoreHomeScreen(),
  LoginHomeScreen.routeName: (context) => LoginHomeScreen(),
  PhoneVerifyPage.routeName: (context) => PhoneVerifyPage(),
  MagazineHomePage.routeName: (context) => MagazineHomePage(),
  BrandDetailScreen.routeName: (context) => BrandDetailScreen(),
  MagazineHomeScreen.routeName: (context) => MagazineHomeScreen(),
  SignupNicknamePage.routeName: (context) => SignupNicknamePage(),
  SearchResultScreen.routeName: (context) => SearchResultScreen(),
  FindingPasswordPage.routeName: (context) => FindingPasswordPage(),
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
