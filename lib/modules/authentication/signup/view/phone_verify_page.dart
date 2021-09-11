import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';

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
      appBar: AppBar(),
      body: PageWire(
          child: BlocListener<SignupCubit, SignupState>(
        bloc: BlocProvider.of<SignupCubit>(context),
        listener: (context, state) async {
          if(state.errorMessage != null) {
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
            Container(
              padding: EdgeInsets.only(bottom: 35),
              width: 100.w,
              child: Text(
                "편리한 서비스 이용을 위해 번호 인증이 필요해요☺️",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            PhoneNumberInputField(),
            if (phoneNumberVerifyStatus == VerifyStatus.request)
              VerifyNumberInput(),
          ],
        ),
      )),
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
          maxLength: 50,
          onChanged: (phoneNumber) =>
              context.read<SignupCubit>().phoneNumberChanged(phoneNumber),
          keyboardType: TextInputType.number,
          inputFormatters: [
            MaskedInputFormatter('000-0000-0000', allowedCharMatcher: RegExp('[0-9]'))
          ],
          decoration: InputDecoration(
              labelText: '전화번호',
              errorText: state.phoneNumber.invalid ? '숫자만 입력 가능합니다.' : null,
              suffixIcon: Container(
                padding: EdgeInsets.only(right: 10),
                child: MaterialButton(
                  color: Colors.grey,
                  onPressed: state.phoneNumber.valid &&
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
                  child: state.phoneNumberVerifyStatus != VerifyStatus.init
                      ? Text(
                          '인증 재발급',
                        )
                      : Text(
                          '전송',
                        ),
                  textColor: Colors.white,
                ),
              )),
        );
      },
    );
  }
}
