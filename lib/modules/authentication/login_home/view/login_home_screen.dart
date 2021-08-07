
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_home.dart';

class LoginHomeScreen extends StatefulWidget {
  static String routeName = 'login_home_screen';

  LoginHomeScreen({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginHomeScreen());
  }

  @override
  State<LoginHomeScreen> createState() => _LoginHomeScreen();
}

class _LoginHomeScreen extends State<LoginHomeScreen> {
  late AuthenticationBloc _authenticationBloc;

  @override
  void initSate() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => BlocProvider.of<AuthenticationBloc>(context),
      ),
    ], child: Scaffold(body: LoginHomePage()));
  }
}
