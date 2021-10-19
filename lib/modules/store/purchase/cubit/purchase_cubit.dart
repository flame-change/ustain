import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/repositories/product_repository/src/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'purchase_state.dart';

class PurchaseCubit extends Cubit {
  PurchaseCubit(this._productRepository) : super(const PurchaseState());

  final ProductRepository _productRepository;


}