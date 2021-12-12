import 'package:aroundus_app/repositories/mypage_repository/src/mypage_repository.dart';
import 'package:aroundus_app/repositories/mypage_repository/models/mypage.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'mypage_state.dart';

class MypageCubit extends Cubit<MypageState> {
  MypageCubit(this._mypageRepository)
      : super(const MypageState(
          isLoading: true,
          isLoaded: false,
        ));

  final MypageRepository _mypageRepository;

  void updateSex(String? sexChoice) {
    Map<String, dynamic> updateMypageInfo =  {
        "group": state.user!["group"],
        "phone": state.user!["phone"],
        "name": state.user!["name"],
        "profileArticle": state.user!["profileArticle"],
        "sexChoices": sexChoice,
        "birthday": state.user!["birthday"],
        "categories": state.user!["categories"],
    };
    emit(state.copyWith(user: updateMypageInfo));
  }

  void updateName(String? name) {
    print(state.user);

    Map<String, dynamic> updateMypageInfo =  {
      "group": state.user!["group"],
      "phone": state.user!["phone"],
      "name": name,
      "profileArticle": state.user!["profileArticle"],
      "sexChoices": state.user!["sexChoices"],
      "birthday": state.user!["birthday"],
      "categories": state.user!["categories"],
    };
    emit(state.copyWith(user: updateMypageInfo));
  }

  void updateBirthDay(String? dateTime) {
    print(state.user);

    Map<String, dynamic> updateMypageInfo =  {
      "group": state.user!["group"],
      "phone": state.user!["phone"],
      "name": state.user!["name"],
      "profileArticle": state.user!["profileArticle"],
      "sexChoices": state.user!["sexChoices"],
      "birthday": dateTime,
      "categories": state.user!["categories"],
    };
    emit(state.copyWith(user: updateMypageInfo));
  }

  Future<void> getMypageInfo() async {
    ApiResult<Mypage> apiResult = await _mypageRepository.getMyPageInfo();

    apiResult.when(success: (Mypage? mypage) {
      emit(state.copyWith(
        user: mypage!.user,
        orderDone: mypage.orderDone,
        magReviews: mypage.magReviews,
        orderReviews: mypage.orderReviews,
        isLoaded: true,
        isLoading: false,
      ));
    }, failure: (NetworkExceptions? error) {
      print('실패함');
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }

  Future<void> updateMypageInfo() async {
    Map<String, dynamic> updateMypageInfo = state.user!;

    ApiResult<Map<String, dynamic>> apiResult = await _mypageRepository.updateMypageInfo(updateMypageInfo);

    apiResult.when(success: (Map<String, dynamic>? mapResponse) {
      emit(state.copyWith(user: mapResponse));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }
}
