import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  SignupCubit? _signupCubit;
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
              _signupCubit!.republishAuthInit();
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
              _signupCubit!.expiredFlagFalse();
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
              _signupCubit!.unverifiedFlagFalse();
            });
          }
          if (state.phoneNumberVerifyStatus == VerifyStatus.verified) {
            // var bloc = BlocProvider.of(context);
            // logger.d(bloc);

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
                          '인증요청',
                        ),
                  textColor: Colors.white,
                ),
              )),
        );
      },
    );
  }
}
