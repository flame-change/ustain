import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:aroundus_app/app.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:aroundus_app/bloc_observer.dart';
import 'main.mapper.g.dart' show initializeJsonMapper;
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty;
import 'repositories/authentication_repository/src/authentication_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioClient dioClient = DioClient(Dio());
  initializeJsonMapper();
  setPathUrlStrategy();
  runApp(App(
    authenticationRepository: AuthenticationRepository(dioClient),
    dioClient: dioClient,
  ));
}
