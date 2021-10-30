import 'dart:io';

import 'package:aroundus_app/app.dart';
import 'package:aroundus_app/bloc_observer.dart';
import 'package:aroundus_app/support/local_notifications/local_notifications.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'repositories/authentication_repository/src/authentication_repository.dart';

Future<void> backgroundHandler(RemoteMessage remoteMessage) async {
  print(remoteMessage.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 애플 개발자 계정 나올 때 까지 임시 처리
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  Bloc.observer = MyBlocObserver();
  DioClient dioClient = DioClient(Dio());

  runApp(App(
    authenticationRepository: AuthenticationRepository(dioClient),
    dioClient: dioClient,
  ));
}
