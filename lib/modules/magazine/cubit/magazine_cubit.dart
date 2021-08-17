import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/magazine.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'magazine_state.dart';

class MagazineCubit extends Cubit<MagazineState> {
  MagazineCubit(this._magazineRepository)
      : super(const MagazineState(isLoading: true, isLoaded: false));

  final MagazineRepository _magazineRepository;

  Future<void> getMainMagazines() async {
    ApiResult<List> apiResult = await _magazineRepository.getMainMagazine();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        magazines: listResponse!
            .map((response) => Magazine.fromJson(response!))
            .toList(),
        isLoaded: true,
        isLoading: false,
      ));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }
}
