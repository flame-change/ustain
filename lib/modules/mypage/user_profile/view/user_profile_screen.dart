import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'user_profile_page.dart';

class UserProfileScreen extends StatefulWidget {
  static String routeName = 'user_profile_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => UserProfileScreen());
  }

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late AuthenticationBloc _authenticationBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => BlocProvider.of<AuthenticationBloc>(context))
        ],
        child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.black,
                brightness: Brightness.dark,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_outlined,
                        color: Colors.white),
                    onPressed: () => Navigator.of(context).pop()),
                actions: [
                  GestureDetector(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.only(right: 20, top: 20),
                          child: Text('완료',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white))))
                ]),
            body: SingleChildScrollView(child: UserProfilePage())));
  }
}
