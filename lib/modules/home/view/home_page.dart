
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthenticationStatus _authenticationStatus;
  late AuthenticationState _authenticationState;

  @override
  void initState() {
    super.initState();
    // _authenticationStatus = context.read<AuthenticationBloc>().state.status;
    // _authenticationState = context.read<AuthenticationBloc>().state;
    // _authenticationStatus == AuthenticationStatus.authenticated &&
    //     _authenticationState.member.agreeService == false
    //     ? Navigator.pushNamed(context, AgreeScreen.routeName)
    //     : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("home page",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
