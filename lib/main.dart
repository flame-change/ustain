import 'package:aroundus_app/app.dart';
import 'package:aroundus_app/bloc_observer.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'repositories/authentication_repository/src/authentication_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioClient dioClient = DioClient(Dio());

  runApp(App(
    authenticationRepository: AuthenticationRepository(dioClient),
    dioClient: dioClient,
  ));
}