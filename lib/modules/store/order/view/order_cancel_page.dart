import 'package:aroundus_app/support/base_component/plain_button.dart';
import 'package:flutter/material.dart';

class OrderCancelPage extends StatelessWidget {
  static String routeName = '/order_cancel_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text("결제가 취소되었습니다.",
                  style: Theme.of(context).textTheme.headline4)),
          PlainButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, "", (route) => false),
              text: "홈 화면으로 이동",
              width: 50)
        ])));
  }
}
