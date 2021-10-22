import 'package:aroundus_app/repositories/cart_repository/models/cart_temp.dart';
import 'package:aroundus_app/repositories/product_repository/product_repository.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productRepository) : super(const ProductState());

  final ProductRepository _productRepository;

  Future<void> getProductDetail(String productId) async {
    ApiResult<Product> apiResult =
        await _productRepository.getProductDetail(productId);

    apiResult.when(success: (Product? productResponse) {
      print("product ${productResponse!}");
      emit(state.copyWith(
        products: [productResponse],
        isLoaded: true,
        isLoading: false,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<void> createCard(Product product, List<CartTemp> cartTemp) async {
    List<dynamic> body = cartTemp
        .map((temp) => {
              "product": product.Id,
              "variant": temp.variants!.Id,
              "quantity": temp.quantity
            })
        .toList();

    print(body);
    ApiResult<Map> apiResult = await _productRepository.createCard(body);

    apiResult.when(success: (Map? mapResponse) {
      print(mapResponse);
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }
}
