import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'signup_category_page.dart';

class SignupNicknamePage extends StatefulWidget {
  static String routeName = 'signup_nickname_page';

  @override
  State<StatefulWidget> createState() => _SignupNicknamePageState();
}

class _SignupNicknamePageState extends State<SignupNicknamePage> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageWire(
        child: Wrap(
          runSpacing: 20,
          children: [
            Text(
              "만나서 반가워요! 😊\n저희가 뭐라고 불러드리면 좋을까요?",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
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
                  return MaterialButton(
                    onPressed: state.nickName.valid
                        ? () => Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider<SignupCubit>.value(
                                  value: BlocProvider.of<SignupCubit>(context,
                                      listen: true),
                                  child: SignupCategoryPage()),
                            ),
                            (route) => false)
                        : null,
                    minWidth: 100.w,
                    color: Colors.grey,
                    child: Text("다음"),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
