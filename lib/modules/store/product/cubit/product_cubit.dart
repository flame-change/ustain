import 'package:aroundus_app/repositories/product_repository/product_repository.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productRepository) : super(const ProductState());

  final ProductRepository _productRepository;

  Future<void> getProductDetail(String productId) async {
    ApiResult<Product> apiResult =
        await _productRepository.getProductDetail(productId);

    apiResult.when(success: (Product? productResponse) {
      print(productResponse!);
      emit(state.copyWith(
        products: [productResponse],
        isLoaded: true,
        isLoading: false,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<void> createCard() async {
    Map body = {
      "product": "MCN3RAV4WV4F",
      "variant": "NJRRT8K5Z8YD",
      "quantity": "3"
    };

    ApiResult<Map> apiResult = await _productRepository.createCard(body);

    apiResult.when(success: (Map? mapResponse) {
      print(mapResponse);
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }
}
