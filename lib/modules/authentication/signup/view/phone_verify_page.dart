import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:logger/logger.dart';

import 'components/verify_number_input.dart';
import 'signup_form_page.dart';

var logger = Logger(printer: PrettyPrinter());

class PhoneVerifyPage extends StatefulWidget {
  static String routeName = 'phone_verify_page';

  @override
  State<StatefulWidget> createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends State<PhoneVerifyPage> {
  late SignupCubit _signupCubit;
  VerifyStatus phoneNumberVerifyStatus = VerifyStatus.init;

  @override
  void initState() {
    super.initState();
    _signupCubit = BlocProvider.of<SignupCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: BlocListener<SignupCubit, SignupState>(
        bloc: BlocProvider.of<SignupCubit>(context),
        listener: (context, state) async {
          if (state.errorMessage != null) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('이미 존재하는 휴대폰입니다.')),
              );
            _signupCubit.errorMsg();
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
              _signupCubit.republishAuthInit();
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
              _signupCubit.expiredFlagFalse();
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
              _signupCubit.unverifiedFlagFalse();
            });
          }
          if (state.phoneNumberVerifyStatus == VerifyStatus.verified) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => BlocProvider<SignupCubit>.value(
                      value:
                          BlocProvider.of<SignupCubit>(context, listen: true),
                      child: SignupForm()),
                ),
                (route) => false);
          }
        },
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: basePadding(),
                  child: RichText(
                    text: TextSpan(
                        style: theme.textTheme.headline2!
                            .copyWith(color: Colors.white, height: 1.5),
                        children: [
                          TextSpan(text: "만나서 반가워요!"),
                          TextSpan(
                              text: ":)",
                              style: theme.textTheme.headline2!
                                  .copyWith(color: theme.accentColor)),
                        ]),
                  )),
            ),
            Flexible(
                flex: 6,
                child: Container(
                    padding: basePadding(vertical: Adaptive.h(4)),
                    height: Adaptive.h(100),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25))),
                    child: Wrap(
                      runSpacing: 15,
                      children: [
                        Text("MOBILE CERTIFICATE",
                            style: theme.textTheme.headline2!
                                .copyWith(fontSize: Adaptive.dp(20))),
                        PhoneNumberInputField(),
                        if (phoneNumberVerifyStatus == VerifyStatus.request)
                          VerifyNumberInput(),
                      ],
                    ))),
          ],
        ),
      ),
    );
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
              suffixIcon: GestureDetector(
                onTap: state.phoneNumber.valid &&
                        state.phoneNumberVerifyStatus != VerifyStatus.verified
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: state.phoneNumberVerifyStatus != VerifyStatus.init
                      ? Text(
                          '인증 재발급',
                          style: theme.textTheme.bodyText2!
                              .copyWith(color: Colors.white),
                        )
                      : Text(
                          '전송',
                          style: theme.textTheme.bodyText2!
                              .copyWith(color: Colors.white),
                        ),
                ),
              )),
        );
      },
    );
  }
}
