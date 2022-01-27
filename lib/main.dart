import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:aroundus_app/my_app.dart';
import 'package:aroundus_app/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:amplitude_flutter/amplitude.dart';
import 'main.mapper.g.dart' show initializeJsonMapper;
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty;
import 'repositories/authentication_repository/src/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  amplitudeMethods();
  Bloc.observer = MyBlocObserver();
  DioClient dioClient = DioClient(Dio());
  initializeJsonMapper();
  runApp(MyApp(
      authenticationRepository: AuthenticationRepository(dioClient),
      dioClient: dioClient));
}

void amplitudeMethods() {
  final Amplitude analytics =
      Amplitude.getInstance(instanceName: "aroundus-ustain");
  analytics.init('e529d03be979b0a303052c6440bb3d02');
  analytics.enableCoppaControl();
  analytics.trackingSessionEvents(true);
}
