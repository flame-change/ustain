import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/page_wire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthenticationRepository _authenticationRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = RepositoryProvider.of<AuthenticationRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
    return PageWire(
      child: Column(
        children: [
          Text("home page",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          MaterialButton(
            color: Colors.grey,
            onPressed: () {
            _authenticationRepository.logOut();
          }, child: Text("로그아웃"),)
        ],
      ),
    );
  }
}
