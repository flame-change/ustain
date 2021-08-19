import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'magazine_detail_state.dart';

class MagazineDetailCubit extends Cubit<MagazineDetailState> {
  MagazineDetailCubit(this._magazineRepository)
      : super(const MagazineDetailState(isLoading: true, isLoaded: false));

  final MagazineRepository _magazineRepository;

  Future<void> getMagazineDetail(int id) async {
    ApiResult<MagazineDetail> apiResult = await _magazineRepository.getMagazineDetail(id);

    apiResult.when(success: (MagazineDetail? magazineDetail) {
      emit(state.copyWith(
        magazineDetail: magazineDetail!,
        isLoading: false,
        isLoaded: true
      ));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }
}