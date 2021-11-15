import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: mainLogo(),
        ),
        bottomNavigationBar: PlainButton(
          onPressed: () => _signupCubit.updateUserProfile(
              nickName: _signupCubit.state.nickName.value.toString(),
              categories: selectedCategory),
          text: "설정 완료",
          height: 10,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: basePadding(vertical: Adaptive.h(5)),
              child: RichText(
                  text: TextSpan(
                      style: theme.textTheme.headline3!
                          .copyWith(color: Colors.white, height: 1.5),
                      children: [
                    TextSpan(text: "가입을 "),
                    TextSpan(
                        text: "축하드려요!\n",
                        style: TextStyle(color: theme.accentColor)),
                    TextSpan(text: "어떤 분야에 가장\n"),
                    TextSpan(text: "관심이 많으신가요?")
                  ]))),
          Container(
              padding: basePadding(vertical: sizeWidth(5)),
              width: sizeWidth(100),
              color: Colors.white,
              child: Wrap(runSpacing: 15, children: [
                Text("PREFERENCES",
                    style: theme.textTheme.headline2!
                        .copyWith(fontSize: Adaptive.dp(20))),
                Wrap(
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
                                    showTopSnackBar(
                                        context,
                                        CustomSnackBar.info(
                                            message:
                                                "관심사는 최대 3개까지만 선택 가능합니다."));
                                  }
                                }
                              });
                            },
                            child: Container(
                                height: Adaptive.h(10),
                                decoration: BoxDecoration(
                                    color: selectedCategory.contains(
                                            user.categories![index].mid)
                                        ? theme.accentColor
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                                child: Row(children: [
                                  Image.network(
                                    "${user.categories![index].snapshotImage}",
                                    width: Adaptive.h(10),
                                    height: Adaptive.h(10),
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: sizeWidth(5)),
                                      child: RichText(
                                          text: TextSpan(
                                              style: theme.textTheme.headline4!,
                                              children: [
                                            TextSpan(
                                                text:
                                                    "${user.categories![index].mid}\n"),
                                            TextSpan(
                                                text:
                                                    "${user.categories![index].title}")
                                          ])))
                                ])))))
              ]))
        ])));
  }
}
