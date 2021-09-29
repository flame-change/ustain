import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart extends Equatable {
  const Cart({
    this.brand,
    this.productId,
    this.productName,
    this.productThumbnail,
    this.variantId,
    this.variantOptions,
    this.salePrice,
    this.quantity,
  });

  final String? brand;
  final String? productId;
  final String? productName;
  final String? productThumbnail;
  final String? variantId;
  final String? variantOptions;
  final String? salePrice;
  final String? quantity;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  Cart copyWith({
    String? brand,
    String? productId,
    String? productName,
    String? productThumbnail,
    String? variantId,
    String? variantOptions,
    String? salePrice,
    String? quantity,
  }) {
    return Cart(
      brand: brand ?? this.brand,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productThumbnail: productThumbnail ?? this.productThumbnail,
      variantId: variantId ?? this.variantId,
      variantOptions: variantOptions ?? this.variantOptions,
      salePrice: salePrice ?? this.salePrice,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        brand,
        productId,
        productName,
        productThumbnail,
        variantId,
        variantOptions,
        salePrice,
        quantity
      ];
}
