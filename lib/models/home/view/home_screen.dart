import 'package:aroundus_app/models/home/home.dart';
import 'package:aroundus_app/module/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home_screen';

  HomeScreen({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    ], child: HomePage());
  }
}
