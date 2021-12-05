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

  Future<void> updateMypageInfo(
      {String? nickName, List<String>? categories}) async {
    Map<String, dynamic> updateMypageInfo = {
      "user": {
        "group": [
          {"id": 6, "level": "1", "name": "애기", "hexCode": "FFFFFF"}
        ],
        "phone": "01066200465",
        "name": "은지킴",
        "profileArticle": null,
        "sexChoices": "FE",
        "birthday": null,
      },
    };

    ApiResult<Map> apiResult =
        await _mypageRepository.updateMypageInfo(updateMypageInfo);

    apiResult.when(
        success: (Map? mapResponse) {},
        failure: (NetworkExceptions? error) {
          emit(state.copyWith(error: error));
        });
  }
}
