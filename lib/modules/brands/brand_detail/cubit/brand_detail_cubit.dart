import 'package:aroundus_app/repositories/brand_repository/src/brand_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/magazine.dart';
import 'package:aroundus_app/repositories/product_repository/models/product.dart';
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

  Future<void> getBrandDetail(String id) async {
    ApiResult<Map> mapResponse = await _brandDetailRepository.getBrand(id);

    mapResponse.when(success: (Map? mapResponse) {
      emit(state.copyWith(
          Id: mapResponse!['Id'],
          name: mapResponse['name'],
          description: mapResponse['description'],
          logo: mapResponse['logo'],
          magazines: mapResponse['magazines']?.cast<Magazine>(),
          products: mapResponse['products']?.cast<Product>(),
          isLoading: false,
          isLoaded: true));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }
}
