import 'package:aroundus_app/modules/authentication/login_home/view/login_home_screen.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';

class LoginNeeded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: Adaptive.h(3)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.grey[200]),
        height: Adaptive.h(20),
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline),
              SizedBox(height: Adaptive.h(1)),
              Text('로그인이 필요한 서비스입니다.',
                  style: Theme.of(context).textTheme.bodyText2),
              SizedBox(height: Adaptive.h(1)),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: webPadding(), vertical: Adaptive.h(1)),
                  child: MaterialButton(
                      minWidth: Adaptive.w(90),
                      padding: EdgeInsets.symmetric(vertical: Adaptive.h(2)),
                      child: Text('로그인', style: TextStyle(color: Colors.white)),
                      color: Colors.black,
                      onPressed: () => Navigator.pushNamed(
                          context, LoginHomeScreen.routeName)))
            ]));
  }
}

void showLoginNeededDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(content: LoginNeeded(), actions: <Widget>[
        FlatButton(
            child: new Text("닫기"), onPressed: () => Navigator.pop(context))
      ]);
    },
  );
}
