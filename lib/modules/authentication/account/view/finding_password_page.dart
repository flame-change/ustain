import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/account/view/view.dart';
import 'package:aroundus_app/modules/authentication/signup/signup.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class FindingPasswordPage extends StatefulWidget {
  static String routeName = 'finding_password_page';

  @override
  State<StatefulWidget> createState() => _FindingPasswordPageState();
}

class _FindingPasswordPageState extends State<FindingPasswordPage> {
  late FindingAccountCubit _findingAccountCubit;
  VerifyStatus phoneNumberVerifyStatus = VerifyStatus.init;

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
          child: BlocListener<FindingAccountCubit, FindingAccountState>(
        bloc: _findingAccountCubit,
        listener: (context, state) async {
          print(state);
          if (state.errorMessage != null) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('${state.errorMessage}')),
              );
          }
          if (state.phoneNumberVerifyStatus == VerifyStatus.request) {
            if (state.phoneNumberVerifyStatus != phoneNumberVerifyStatus) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('인증번호가 발급되었습니다.')),
                );
            } else if (state.republishFlag) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('인증번호가 재발급되었습니다.')),
                );
            }
            setState(() {
              phoneNumberVerifyStatus = state.phoneNumberVerifyStatus;
              _findingAccountCubit.republishAuthInit();
            });
          }
          if (state.phoneNumberVerifyStatus == VerifyStatus.expiered &&
              state.expiredFlag) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('인증번호 입력시간이 만료되었습니다.')),
              );
            setState(() {
              _findingAccountCubit.expiredFlagFalse();
            });
          }
          if (state.phoneNumberVerifyStatus == VerifyStatus.unverified &&
              state.unverifiedFlag) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('인증번호가 일치하지 않습니다.')),
              );
            setState(() {
              _findingAccountCubit.unverifiedFlagFalse();
            });
          }
          if (state.phoneNumberVerifyStatus == VerifyStatus.verified) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (_) => BlocProvider<FindingAccountCubit>.value(
                          value: _findingAccountCubit,
                          child: FindingPasswordResultPage(),
                        )),
                (route) => false);
          }
        },
        child: Wrap(
          runSpacing: 20,
          spacing: 20,
          children: [
            Text(
              "가입하신 휴대폰 번호를 입력해주세요.",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                FindingPhoneNumberInputField(),
                if (_findingAccountCubit.state.phoneNumberVerifyStatus == VerifyStatus.request)
                  FindingVerifyNumberInput(),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
