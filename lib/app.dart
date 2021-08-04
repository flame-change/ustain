import 'package:aroundus_app/repositories/user_repository/src/user_repository.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_view.dart';
import 'authentication/authentication.dart';
import 'repositories/repositories.dart';

class App extends StatelessWidget {
  const App({
    required this.authenticationRepository,
    required this.dioClient,
  });

  final AuthenticationRepository authenticationRepository;
  final DioClient dioClient;

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository(dioClient);

    return MultiRepositoryProvider(providers: [
      RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository),
    ], child: MultiBlocProvider(providers: [
      BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(
                  authenticationRepository: authenticationRepository,
                  userRepository: userRepository)),
    ], child: AppView()));
  }
}
