import 'package:aroundus_app/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';

class LoginNeeded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: Adaptive.h(3)),
        height: 175,
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline),
              SizedBox(height: 10),
              Text('로그인이 필요한 서비스입니다.',
                  style: Theme.of(context).textTheme.bodyText2),
              SizedBox(height: 10),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeWidth(5), vertical: 10),
                  child: MaterialButton(
                      minWidth: sizeWidth(90),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text('Login / Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white)),
                      color: Colors.black,
                      onPressed: () =>
                          RepositoryProvider.of<AuthenticationRepository>(
                                  context)
                              .logOut()))
            ]));
  }
}

void showLoginNeededDialog(context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      builder: (context) => Container(
          height: 250,
          padding: EdgeInsets.all(sizeWidth(5)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Login / Register',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black)),
            SizedBox(height: 15),
            Text('로그인이 필요한 서비스입니다.'),
            Text('1분만에 회원가입!'),
            SizedBox(height: 15),
            GestureDetector(
                onTap: () =>
                    RepositoryProvider.of<AuthenticationRepository>(context)
                        .logOut(),
                child: Container(
                    color: Colors.black,
                    height: 50,
                    child: Center(
                        child: Text('로그인 / 회원가입',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white))))),
          ])),
      isScrollControlled: true);
}
