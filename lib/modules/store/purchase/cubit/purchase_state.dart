part of 'purchase_cubit.dart';

class PurchaseState extends Equatable {
  const PurchaseState({
    this.product,
  });

  final Product? product;

  @override
  List<Object?> get props => [
        product,
      ];

  PurchaseState copyWith({
    Product? product,
  }) {
    return PurchaseState(
      product: product ?? this.product,
    );
  }
}
