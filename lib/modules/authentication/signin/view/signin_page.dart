import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/account/view/finding_password_page.dart';
import 'package:aroundus_app/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class SignInPage extends StatefulWidget {
  static String routeName = 'signIn_page';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late SignInCubit _signInCubit;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _signInCubit = BlocProvider.of<SignInCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: PageWire(
          child: BlocListener<SignInCubit, SignInState>(
            listener: (context, state) async {
              if (state.errorMessage != null && state.errorMessage!.length >0)
              {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('${state.errorMessage}')),
                  );
                _signInCubit.errorMsg();
              }
            },
            child: Wrap(
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    height: Adaptive.h(10),
                    child: Text("다시 만나서 반가워요! 😊")),
                _phoneNumberInput(),
                _passwordInput(),
                MaterialButton(
                  minWidth: Adaptive.w(100),
                  color: Colors.grey,
                  onPressed: () {
                    _signInCubit.signIn(
                        phoneNumber: _phoneNumberController.text.trim().replaceAll("-", ""),
                        password: _passwordController.text.trim());
                  },
                  child: Text("로그인"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider<FindingAccountCubit>(
                            create: (context) => FindingAccountCubit(
                              RepositoryProvider.of<AuthenticationRepository>(context),
                            ),
                            child: FindingPasswordPage(),
                          ),
                        ));
                  },
                  child: Text("비밀번호 찾기"),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _phoneNumberInput() {
    return TextFormField(
      maxLength: 60,
      keyboardType: TextInputType.phone,
      controller: _phoneNumberController,
      inputFormatters: [
        MaskedInputFormatter('000-0000-0000', allowedCharMatcher: RegExp('[0-9]'))
      ],
      decoration: InputDecoration(
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.4),
          contentPadding:
              EdgeInsets.only(left: 11, bottom: 10, top: 10, right: 11),
          hintText: "휴대폰 번호",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 13.0,
          )),
    );
  }

  Widget _passwordInput() {
    return TextFormField(
      maxLength: 60,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      controller: _passwordController,
      decoration: InputDecoration(
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.4),
          contentPadding:
              EdgeInsets.only(left: 11, bottom: 10, top: 10, right: 11),
          hintText: "비밀번호",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 13.0,
          )),
    );
  }
}
