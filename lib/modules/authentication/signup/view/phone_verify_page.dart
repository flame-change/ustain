import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/verify_number_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'signup_form_page.dart';

var logger = Logger(printer: PrettyPrinter());

class PhoneVerifyPage extends StatefulWidget {
  static String routeName = '/phone_verify_page';

  @override
  State<StatefulWidget> createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends State<PhoneVerifyPage> {
  VerifyStatus phoneNumberVerifyStatus = VerifyStatus.init;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: mainLogo(),
        ),
        body: BlocListener<SignupCubit, SignupState>(
            bloc: BlocProvider.of<SignupCubit>(context),
            listener: (context, state) async {
              if (state.phoneNumberVerifyStatus == VerifyStatus.request) {
                if (state.phoneNumberVerifyStatus != phoneNumberVerifyStatus) {
                  showTopSnackBar(
                      context, CustomSnackBar.info(message: "인증번호가 발급되었습니다."));
                } else if (state.republishFlag) {
                  showTopSnackBar(context,
                      CustomSnackBar.info(message: "인증번호가 재발급 되었습니다.."));
                }
                setState(() {
                  phoneNumberVerifyStatus = state.phoneNumberVerifyStatus;
                  BlocProvider.of<SignupCubit>(context).republishAuthInit();
                });
              }
              if (state.phoneNumberVerifyStatus == VerifyStatus.expiered &&
                  state.expiredFlag) {
                showTopSnackBar(
                    context, CustomSnackBar.error(message: "입력 시간이 만료되었습니다."));
                setState(() {
                  BlocProvider.of<SignupCubit>(context).expiredFlagFalse();
                });
              }
              if (state.phoneNumberVerifyStatus == VerifyStatus.unverified &&
                  state.unverifiedFlag) {
                showTopSnackBar(
                    context, CustomSnackBar.error(message: "인증번호가 일치하지 않습니다."));
                setState(() {
                  BlocProvider.of<SignupCubit>(context).unverifiedFlagFalse();
                });
              }
              if (state.phoneNumberVerifyStatus == VerifyStatus.verified) {
                BlocProvider.of<SignupCubit>(context).completeVerify();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider<SignupCubit>.value(
                            value: BlocProvider.of<SignupCubit>(context),
                            child: SignupForm())));
              }

              if (state.errorMessage != null &&
                  state.errorMessage!.length > 0) {
                showTopSnackBar(
                    context,
                    CustomSnackBar.error(
                        message: phoneNumberVerifyStatus != VerifyStatus.request
                            ? "이미 가입된 번호입니다."
                            : "인증번호를 다시 한 번 확인 해 주세요."));
                context.read<SignupCubit>().errorMsg();
              }
            },
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                  color: Colors.black,
                  alignment: Alignment.centerLeft,
                  padding: basePadding(vertical: Adaptive.h(10)),
                  child: RichText(
                      text: TextSpan(
                          style: theme.textTheme.headline2!
                              .copyWith(color: Colors.white, height: 1.5),
                          children: [
                        TextSpan(text: "만나서 반가워요!"),
                        TextSpan(
                            text: ":)",
                            style: theme.textTheme.headline2!
                                .copyWith(color: theme.accentColor))
                      ]))),
              Container(
                  color: Colors.black,
                  child: Container(
                      padding: basePadding(vertical: Adaptive.h(4)),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25))),
                      child: Wrap(runSpacing: 15, children: [
                        Text("MOBILE CERTIFICATE",
                            style: theme.textTheme.headline2!
                                .copyWith(fontSize: Adaptive.dp(20))),
                        PhoneNumberInputField(),
                        if (phoneNumberVerifyStatus == VerifyStatus.request)
                          VerifyNumberInput()
                      ])))
            ]))));
  }
}

class PhoneNumberInputField extends StatelessWidget {
  String _updatePhoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
        buildWhen: (pre, cur) =>
            pre.phoneNumber != cur.phoneNumber ||
            pre.phoneNumberVerifyStatus != cur.phoneNumberVerifyStatus,
        builder: (context, state) {
          return TextFormField(
              key: Key('phoneNumber_code_textFormField'),
              onChanged: (phoneNumber) =>
                  context.read<SignupCubit>().phoneNumberChanged(phoneNumber),
              keyboardType: TextInputType.number,
              inputFormatters: [
                MaskedInputFormatter('000-0000-0000',
                    allowedCharMatcher: RegExp('[0-9]'))
              ],
              decoration: InputDecoration(
                  labelText: '휴대폰 번호',
                  errorText: state.phoneNumber.invalid ? '숫자만 입력 가능합니다.' : null,
                  suffixIcon: InkWell(
                      onTap: state.phoneNumber.valid &&
                              state.phoneNumberVerifyStatus !=
                                  VerifyStatus.verified
                          ? () {
                              if (state.phoneNumberVerifyStatus !=
                                  VerifyStatus.init) {
                                context
                                    .read<SignupCubit>()
                                    .phoneNumberVerifyRequest();
                                context.read<SignupCubit>().republishAuth();
                              } else {
                                context
                                    .read<SignupCubit>()
                                    .phoneNumberVerifyRequest();
                              }
                            }
                          : null,
                      child: Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child:
                              state.phoneNumberVerifyStatus != VerifyStatus.init
                                  ? Text(
                                      '인증 재발급',
                                      style: theme.textTheme.bodyText2!
                                          .copyWith(color: Colors.white),
                                    )
                                  : Text('전송',
                                      style: theme.textTheme.bodyText2!
                                          .copyWith(color: Colors.white))))));
        });
  }
}
