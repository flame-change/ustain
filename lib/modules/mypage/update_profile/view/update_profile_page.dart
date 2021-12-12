import 'package:aroundus_app/modules/mypage/cubit/mypage_cubit.dart';
import 'package:aroundus_app/support/base_component/page_wire.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late MypageCubit _mypageCubit;

  @override
  void initState() {
    super.initState();
    _mypageCubit = BlocProvider.of<MypageCubit>(context);
    _mypageCubit.getMypageInfo();
    print(_mypageCubit.state.user);
  }

  @override
  Widget build(BuildContext context) {
    return PageWire(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('프로필 수정', style: Theme.of(context).textTheme.headline4),
      BlocBuilder<MypageCubit, MypageState>(builder: (context, state) {
        print("state.user${state.user}");

        if (state.isLoaded == true) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Adaptive.h(3)),
                Text('닉네임'),
                TextFormField(
                    onChanged: (value) {
                      _mypageCubit.updateName(value);
                    },
                    decoration: InputDecoration(hintText: state.user!['name'])),
                SizedBox(height: Adaptive.h(3)),
                Text('성별'),
                SizedBox(height: Adaptive.h(1)),
                Row(children: [
                  sexChoice('여성', "FE"),
                  SizedBox(width: sizeWidth(5)),
                  sexChoice('남성', "ME")
                ]),
                SizedBox(height: Adaptive.h(3)),
                Text('생년월일'),
                SizedBox(height: Adaptive.h(3)),
                GestureDetector(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: Adaptive.h(1)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(sizeWidth(3))),
                      child: Center(
                          child: Text(
                              state.user!['birthday'] != null
                                  ? '${state.user!['birthday']}'
                                  : '생년월일을 입력해주세요.',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontWeight: FontWeight.w400)))),
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1900),
                        maxTime: DateTime.now(), onChanged: (date) {
                      _mypageCubit.updateBirthDay(DateFormat("yyyy년 MM월 dd일").format(date));
                    }, onConfirm: (date) {
                      _mypageCubit.updateBirthDay(DateFormat("yyyy년 MM월 dd일").format(date));
                    }, currentTime: DateTime.now(), locale: LocaleType.ko);
                  },
                ),
                SizedBox(height: Adaptive.h(3)),
                Text('관심 분야'),
                SizedBox(height: Adaptive.h(1)),
              ]);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      })
    ]));
  }

  Expanded sexChoice(String title, String sexChoice) {
    return Expanded(
        child: GestureDetector(
            onTap: () {
              _mypageCubit.updateSex(sexChoice);
              print(_mypageCubit.state.user);
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: Adaptive.h(1.5)),
                decoration: BoxDecoration(
                    color: _mypageCubit.state.user!["sexChoices"] == sexChoice
                        ? Colors.black
                        : Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(sizeWidth(10))),
                child: Center(
                    child: Text('${title}',
                        style: TextStyle(
                            color: _mypageCubit.state.user!["sexChoices"] ==
                                    sexChoice
                                ? Colors.white
                                : Colors.black))))));
  }
}
