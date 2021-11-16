import 'package:aroundus_app/repositories/brand_repository/src/brand_repository.dart';
import 'package:aroundus_app/repositories/brand_repository/models/brand_detail.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'brand_detail_state.dart';

class BrandDetailCubit extends Cubit<BrandDetailState> {
  BrandDetailCubit(this._brandDetailRepository)
      : super(const BrandDetailState(isLoading: true, isLoaded: false));

  final BrandRepository _brandDetailRepository;

  Future<void> getMagazineDetail(String id) async {
    ApiResult<BrandDetail> apiResult =
        await _brandDetailRepository.getBrand(id);

    apiResult.when(success: (BrandDetail? brandDetail) {
      emit(state.copyWith(
          brandDetail: brandDetail!, isLoading: false, isLoaded: true));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }
}
