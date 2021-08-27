import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:aroundus_app/modules/authentication/signin/view/signin_page.dart';
import 'package:aroundus_app/modules/authentication/signup/models/email.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class FindingPassWordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FindingPassWordPageState();
}

class _FindingPassWordPageState extends State<FindingPassWordPage> {
  final TextEditingController _emailController = TextEditingController();

  late FindingAccountCubit _findingAccountCubit;

  @override
  void initState() {
    super.initState();
    _findingAccountCubit = BlocProvider.of<FindingAccountCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageWire(
        child: BlocBuilder<FindingAccountCubit, FindingAccountState>(
            builder: (context, state) {
          return Wrap(
            runSpacing: 15,
            children: [
              Text(
                "가입하신 이메일을 입력해주세요.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
              TextFormField(
                  controller: _emailController,
                  onChanged: (email) => _findingAccountCubit.emailChanged(email),
                  decoration: InputDecoration(
                    labelText: "이메일",
                    helperText: '',
                    errorText: Email.dirty(_emailController.value.text).invalid
                        ? '올바른 이메일 양식 입력해주세요'
                        : null,
                  )),
              MaterialButton(
                minWidth: 100.w,
                color: Colors.grey,
                onPressed: () async {
                  await _findingAccountCubit.findingPasswordEmailVerifyRequest();
                  Navigator.pushNamedAndRemoveUntil(context, 'finding_password_result', (route) => false);
                },
                child: Text("인증하기"),
              )
            ],
          );
        }),
      ),
    );
  }
}
