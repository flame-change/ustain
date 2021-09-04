import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/magazine.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SignupCategoryPage extends StatefulWidget {
  static String routeName = 'signup_category_page';

  @override
  State<StatefulWidget> createState() => _SignupCategoryPageState();
}

class _SignupCategoryPageState extends State<SignupCategoryPage> {
  final TextEditingController _nicknameController = TextEditingController();

  late SignupCubit _signupCubit;
  List? categories;
  late User user;
  List<String> selectedCategory = [];

  @override
  void initState() {
    super.initState();
    _signupCubit = BlocProvider.of<SignupCubit>(context);
    user = BlocProvider.of<AuthenticationBloc>(context).state.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: PageWire(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "가입을 축하드립니다! 🎉\n"
                "${_signupCubit.state.nickName.value.toString()} 님은 어떤 분야에 관심이 많으신가요? 🤔 세 가지를 골라주세요!",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              Container(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List.generate(
                      user.categories!.length,
                      (index) => GestureDetector(
                            onTap: () {
                              print("${user.categories![index].mid}");
                              setState(() {
                                if (selectedCategory
                                    .contains(user.categories![index].mid)) {
                                  selectedCategory
                                      .remove(user.categories![index].mid!);
                                } else {
                                  if (selectedCategory.length < 3) {
                                    selectedCategory
                                        .add(user.categories![index].mid!);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('관심사는 최대 3개까지만 가능합니다.'),
                                      ),
                                    );
                                  }
                                }
                              });
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Opacity(
                                    opacity: selectedCategory.contains(
                                            user.categories![index].mid)
                                        ? 0.5
                                        : 1,
                                    child: CircleAvatar(
                                      radius: 50,
                                      foregroundImage: NetworkImage(
                                          "${user.categories![index].snapshotImage}"),
                                      foregroundColor: Colors.lightBlue,
                                    ),
                                  ),
                                  Text("${user.categories![index].title}"),
                                ],
                              ),
                            ),
                          )),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  _signupCubit.updateUserProfile(nickName: _signupCubit.state.nickName.value.toString(), categories: selectedCategory);
                },
                minWidth: 100.w,
                child: Text("선택완료"),
              ),
              InkWell(
                onTap: () {
                  // TODO 건너뛰기 값 서버 처리
                  // _signupCubit.updateUserProfile(nickName: _signupCubit.state.nickName.value, categories: [""]);
                  // Navigator.pushNamed(context, 'home_screen');
                },
                child: Text(
                  "건너뛰기",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
