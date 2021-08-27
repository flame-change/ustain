import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:aroundus_app/modules/authentication/signin/view/signin_page.dart';
import 'package:aroundus_app/modules/authentication/signup/models/email.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class FindingPassWordResultPage extends StatefulWidget {
  static String routeName = 'finding_password_result';

  @override
  State<StatefulWidget> createState() => _FindingPassWordResultPageState();
}

class _FindingPassWordResultPageState extends State<FindingPassWordResultPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageWire(
        child: Wrap(
          runSpacing: 15,
          children: [
            Text(
              "입력하신 이메일로 비밀번호 재설정 링크를 보냈어요!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
            MaterialButton(
              minWidth: 100.w,
              color: Colors.grey,
              onPressed: () {
                Navigator.pushNamed(context, 'login_home_screen');
              },
              child: Text("로그인 하러가기"),
            )
          ],
        ),
      ),
    );
  }
}
