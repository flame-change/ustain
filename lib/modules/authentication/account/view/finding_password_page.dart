import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FindingPasswordPage extends StatefulWidget {
  static String routeName = '/finding_password_page';

  @override
  State<StatefulWidget> createState() => _FindingPasswordPageState();
}

class _FindingPasswordPageState extends State<FindingPasswordPage> {
  late FindingAccountCubit _findingAccountCubit;
  String _text = '재설정 링크 전송';
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _findingAccountCubit = BlocProvider.of<FindingAccountCubit>(context);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.black, title: mainLogo()),
        body: BlocBuilder<FindingAccountCubit, FindingAccountState>(
            builder: (context, state) {
          return SingleChildScrollView(
              child: Column(children: [
            Container(
                alignment: Alignment.centerLeft,
                padding: basePadding(),
                height: Adaptive.h(30),
                color: Colors.black,
                child: RichText(
                    text: TextSpan(
                        style: theme.textTheme.headline3!
                            .copyWith(color: Colors.white, height: 1.5),
                        children: [
                      TextSpan(
                          text: "고객님의 번호",
                          style: theme.textTheme.headline3!
                              .copyWith(color: theme.accentColor)),
                      TextSpan(text: "로\n"),
                      TextSpan(text: "재설정 링크를 \n"),
                      TextSpan(text: "보내드려요! \n")
                    ]))),
            Container(
                padding: basePadding(vertical: Adaptive.h(4)),
                child: Wrap(runSpacing: 15, children: [
                  Text("FIND PASSWORD",
                      style: theme.textTheme.headline2!
                          .copyWith(fontSize: Adaptive.dp(20))),
                  TextFormField(
                      key:
                          Key('finding_account_phoneNumber_code_textFormField'),
                      inputFormatters: [
                        MaskedInputFormatter('000-0000-0000',
                            allowedCharMatcher: RegExp('[0-9]'))
                      ],
                      controller: _textEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '휴대폰 번호')),
                  PlainButton(
                      text: _text,
                      onPressed: () {
                        _findingAccountCubit
                            .findingPhoneNumberVerifyRequest(
                                _textEditingController.text)
                            .whenComplete(() => {
                                  showTopSnackBar(
                                      context,
                                      CustomSnackBar.info(
                                          message: "재설정 링크가 전송 되었습니다."))
                                });
                        setState(() {
                          _text = '재설정 링크 재전송';
                        });
                      })
                ]))
          ]));
        }));
  }
}
