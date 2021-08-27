import 'package:aroundus_app/modules/authentication/signin/view/signin_page.dart';
import 'package:aroundus_app/modules/authentication/signup/models/email.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FindingEmailResultPage extends StatefulWidget {
  final Email email;

  const FindingEmailResultPage({Key? key, required this.email})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FindingEmailResultPageState();
}

class _FindingEmailResultPageState extends State<FindingEmailResultPage>
    with SingleTickerProviderStateMixin {
  Email get _email => this.widget.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageWire(
        child: Wrap(
          runSpacing: 15,
          children: [
            Text(
              "가입하신 이메일은 ${_email.value}입니다.",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            MaterialButton(
                minWidth: 100.w,
                color: Colors.grey,
                child: Text("로그인 하러가기"),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'login_home_screen', (route) => false);
                }),
            PlainButton(text: "비밀번호 찾기", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
