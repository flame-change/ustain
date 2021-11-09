import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'signup_category_page.dart';

class SignupNicknamePage extends StatefulWidget {
  static String routeName = 'signup_nickname_page';

  @override
  State<StatefulWidget> createState() => _SignupNicknamePageState();
}

class _SignupNicknamePageState extends State<SignupNicknamePage> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.black, title: mainLogo()),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Container(
                  color: Colors.black,
                  alignment: Alignment.centerLeft,
                  padding: basePadding(vertical: Adaptive.w(5)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: double.infinity, height: Adaptive.h(5)),
                        Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset('assets/icons/party.svg',
                                height: 100,
                                width: 100,
                                color: theme.accentColor)),
                        SizedBox(width: double.infinity, height: Adaptive.h(5)),
                        RichText(
                            text: TextSpan(
                                style: theme.textTheme.headline2!
                                    .copyWith(color: Colors.white, height: 1.5),
                                children: [
                              TextSpan(text: "안녕하세요!"),
                              TextSpan(
                                  text: ":)\n",
                                  style: TextStyle(color: theme.accentColor)),
                              TextSpan(text: "저희가 어떻게\n"),
                              TextSpan(text: "불러드리면 좋을까요?")
                            ])),
                        SizedBox(width: double.infinity, height: Adaptive.h(5))
                      ])),
              Container(
                  color: Colors.black,
                  child: Container(
                      padding: basePadding(vertical: Adaptive.w(5)),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25))),
                      child: Wrap(runSpacing: 15, children: [
                        Text("NICKNAME",
                            style: theme.textTheme.headline2!
                                .copyWith(fontSize: Adaptive.dp(20))),
                        BlocBuilder<SignupCubit, SignupState>(
                            buildWhen: (previous, current) =>
                                previous.nickName != current.nickName,
                            builder: (context, state) {
                              return TextFormField(
                                controller: _nicknameController,
                                decoration: InputDecoration(labelText: "닉네임"),
                                onChanged: (newNickName) => context
                                    .read<SignupCubit>()
                                    .nickNameChanged(newNickName),
                                maxLength: 25,
                              );
                            }),
                        BlocBuilder<SignupCubit, SignupState>(
                            buildWhen: (previous, current) =>
                                previous.nickName != current.nickName,
                            builder: (context, state) {
                              return PlainButton(
                                  onPressed: state.nickName.valid
                                      ? () => Navigator.of(context)
                                          .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (_) => BlocProvider<
                                                          SignupCubit>.value(
                                                      value: BlocProvider.of<
                                                              SignupCubit>(
                                                          context,
                                                          listen: true),
                                                      child:
                                                          SignupCategoryPage())),
                                              (route) => false)
                                      : null,
                                  text: "설정완료");
                            })
                      ])))
            ])));
  }
}
