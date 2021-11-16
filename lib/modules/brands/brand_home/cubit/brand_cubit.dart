import 'package:aroundus_app/repositories/brand_repository/models/brand_list.dart';
import 'package:aroundus_app/repositories/brand_repository/src/brand_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/page_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'brand_state.dart';

class BrandCubit extends Cubit<BrandListState> {
  BrandCubit(this._brandRepository)
      : super(const BrandListState(
          isLoading: true,
          isLoaded: false,
          maxIndex: false,
          page: 1,
        ));

  final BrandRepository _brandRepository;

  Future<void> getMainMagazines() async {
    ApiResult<PageResponse> apiResult =
        await _brandRepository.getBrandList(state.page);

    apiResult.when(success: (PageResponse? pageResponse) {
      List<BrandList>? newBrandList =
          pageResponse!.results?.map((e) => BrandList.fromJson(e)).toList();

      emit(state.copyWith(
          brands: state.brands != null
              ? state.brands! + newBrandList!
              : newBrandList!,
          count: pageResponse.count,
          page: state.page + 1,
          next: pageResponse.next,
          previous: pageResponse.previous,
          maxIndex: pageResponse.next == null ? true : false,
          isLoaded: true,
          isLoading: false));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }
}
