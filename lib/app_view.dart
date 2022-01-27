import 'repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'modules/authentication/bloc/authentication_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aroundus_app/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'modules/splash/splash.dart';
import 'support/style/theme.dart';

class AppView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          navigatorKey: _navigatorKey,
          builder: (context, child) {
            DioClient.authenticationBloc =
                BlocProvider.of<AuthenticationBloc>(context);

            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: buildMultiBlocListener(child!));
          },
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('ko', 'KR'),
            const Locale('en', 'US')
          ],
          initialRoute: SplashPage.routeName,
          routes: routes,
          navigatorObservers: <NavigatorObserver>[observer]);
    });
  }

  MultiBlocListener buildMultiBlocListener(Widget child) {
    return MultiBlocListener(listeners: [
      BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.profile:
            _navigator!.pushNamedAndRemoveUntil(
                '/signup_nickname_page', (route) => false);
            break;
          case AuthenticationStatus.authenticated:
            _navigator!.pushNamed('');
            break;
          case AuthenticationStatus.unauthenticated:
            _navigator!.pushNamed('/login_home_screen');
            break;
          case AuthenticationStatus.unknown:
            _navigator!.pushNamed('');
            break;
          default:
            break;
        }
      })
    ], child: child);
  }
}
