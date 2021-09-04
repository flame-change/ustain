import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/routes.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';

import 'modules/authentication/bloc/authentication_bloc.dart';
import 'modules/splash/splash.dart';
import 'repositories/authentication_repository/authentication_repository.dart';
import 'support/style/theme.dart';

class AppView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        theme: theme,
        navigatorKey: _navigatorKey,
        builder: (context, child) {
          DioClient.authenticationBloc =
              BlocProvider.of<AuthenticationBloc>(context);

          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            //set desired text scale factor here
            child: buildMultiBlocListener(child!),
          );
        },
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ko', 'KR'),
          const Locale('en', 'US'),
        ],
        initialRoute: SplashPage.routeName,
        routes: routes,
      );
    });
  }

  MultiBlocListener buildMultiBlocListener(Widget child) {
    return MultiBlocListener(listeners: [
      BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.profile:
              _navigator!.pushNamedAndRemoveUntil(
                  'signup_nickname_page', (route) => false);
              break;
            case AuthenticationStatus.authenticated:
              _navigator!
                  .pushNamedAndRemoveUntil('home_screen', (route) => false);
              break;
            case AuthenticationStatus.unauthenticated:
              _navigator!.pushNamedAndRemoveUntil(
                  'login_home_screen', (route) => false);
              break;
            default:
              break;
          }
        },
      ),
    ], child: child);
  }
}
