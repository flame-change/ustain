import 'dart:io';

import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/routes.dart';
import 'package:aroundus_app/support/local_notifications/local_notifications.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
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
  void initState() {
    super.initState();
    // 애플 개발자 계정 나올 때 까지 임시 처리
    if (Platform.isAndroid) {
      LocalNotificationService.initialize(context);

      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          final routeFromMessage = message.data["route"];

          Navigator.of(context).pushNamed(routeFromMessage);
        }
      });
      // 어스테인 켜져 있는 상태
      FirebaseMessaging.onMessage.listen((message) {
        if (message.notification != null) {
          print(message.notification!.body);
          print(message.notification!.title);
        }

        LocalNotificationService.display(message);
      });
      // 어스테인 백그라운드에서 실행 중일 경우 (켜져 있는 상태)
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        final routeFromMessage = message.data["route"];

        Navigator.of(context).pushNamed(routeFromMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, deviceType) {
        return FlutterWebFrame(
          builder: (context) {
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
          },
          maximumSize: Size(375.0, 812.0),
          enabled: kIsWeb,
          backgroundColor: Colors.grey,
        );
      },
    );
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
                  .pushNamedAndRemoveUntil('main_screen', (route) => false);
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
