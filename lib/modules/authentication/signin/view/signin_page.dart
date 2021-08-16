import 'package:aroundus_app/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  static String routeName = 'signIn_page';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late SignInCubit _signInCubit;

  final TextEditingController _emailController = TextEditingController();
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
              if (state.auth != null) {
                Navigator.pushNamed(context, 'home_screen');
              }
              if (state.errorMessage != null) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('${state.errorMessage}')),
                  );
              }
            },
            child: Column(
              children: [
                _emailInput(),
                _passwordInput(),
                MaterialButton(
                  onPressed: () {
                    context.read<SignInCubit>().signIn(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim());
                  },
                  child: Text("로그인"),
                )
              ],
            ),
          ),
        ));
  }

  Widget _emailInput() {
    return TextFormField(
      maxLength: 60,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
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
          hintText: "이메일",
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
