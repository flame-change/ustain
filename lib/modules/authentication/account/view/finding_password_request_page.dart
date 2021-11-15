import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/account/view/view.dart';
import 'package:aroundus_app/modules/authentication/signup/signup.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FindingPasswordRequestPage extends StatefulWidget {
  static String routeName = '/finding_password_request_page';

  @override
  State<StatefulWidget> createState() => _FindingPasswordRequestPageState();
}

class _FindingPasswordRequestPageState
    extends State<FindingPasswordRequestPage> {
  late FindingAccountCubit _findingAccountCubit;
  VerifyStatus phoneNumberVerifyStatus = VerifyStatus.init;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _findingAccountCubit = BlocProvider.of<FindingAccountCubit>(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.black, title: mainLogo()),
        body: BlocListener<FindingAccountCubit, FindingAccountState>(
            bloc: _findingAccountCubit,
            listener: (context, state) async {
              // 인증에 성공한 경우
              if (state.phoneNumberVerifyStatus == VerifyStatus.verified) {
                _findingAccountCubit.completeVerify();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider<FindingAccountCubit>.value(
                            value: _findingAccountCubit,
                            child: FindingPasswordResultPage())));
              }

              // 만료된 경우 - 현재 사용 안됨
              // if (state.phoneNumberVerifyStatus == VerifyStatus.expiered &&
              //     state.expiredFlag) {
              //   showTopSnackBar(context,
              //       CustomSnackBar.info(message: '인증번호 입력 시간이 만료 되었습니다.'));
              //   setState(() {
              //     _findingAccountCubit.expiredFlagFalse();
              //   });
              // }

              // 일치하지 않는 경우
              if (state.phoneNumberVerifyStatus == VerifyStatus.unverified &&
                  state.unverifiedFlag) {
                showTopSnackBar(
                    context, CustomSnackBar.info(message: '인증번호가 일치하지 않습니다.'));
                setState(() {
                  _findingAccountCubit.unverifiedFlagFalse();
                  controller.clear();
                });
              }

              if (state.errorMessage != null && state.errorMessage.length > 0) {
                showTopSnackBar(context,
                    CustomSnackBar.info(message: "${state.errorMessage}"));
              }
            },
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                  color: Colors.black,
                  height: Adaptive.h(30),
                  alignment: Alignment.centerLeft,
                  padding: basePadding(),
                  child: RichText(
                      text: TextSpan(
                          style: theme.textTheme.headline2!
                              .copyWith(color: Colors.white, height: 1.5),
                          children: [
                        TextSpan(
                            text: "휴대폰번호",
                            style: theme.textTheme.headline2!
                                .copyWith(color: theme.accentColor)),
                        TextSpan(text: "를\n"),
                        TextSpan(text: "입력 해 주세요!")
                      ]))),
              Container(
                  child: Container(
                      padding: basePadding(vertical: Adaptive.h(4)),
                      child: Wrap(runSpacing: 15, children: [
                        Text("OTP CERTIFICATE",
                            style: theme.textTheme.headline2!
                                .copyWith(fontSize: Adaptive.dp(20))),
                        PinCodeTextField(
                            appContext: context,
                            length: 6,
                            controller: controller,
                            animationType: AnimationType.fade,
                            animationDuration: Duration(milliseconds: 100),
                            cursorColor: theme.accentColor,
                            pinTheme: PinTheme(
                              activeColor: Colors.grey,
                              inactiveColor: Colors.black,
                              selectedColor: theme.accentColor,
                            ),
                            onChanged: (value) {
                              _findingAccountCubit.verifyNumberChanged(value);
                            }),
                        PlainButton(
                            text: "인증 완료",
                            onPressed: () {
                              _findingAccountCubit.findingPassWordVerify();
                            })
                      ])))
            ]))));
  }
}
