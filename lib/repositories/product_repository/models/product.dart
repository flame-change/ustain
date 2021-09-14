import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  const Product(
      {this.Id,
      this.name,
      this.summary,
      this.description,
      this.rating,
      this.originalPrice,
      this.discountPrice,
      this.discountRate,
      this.brand});

  final String? Id;
  final String? name;
  final String? summary;
  final String? description;
  final String? rating;
  final String? originalPrice;
  final String? discountPrice;
  final String? discountRate;
  final String? brand;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [
        Id,
        name,
        summary,
        description,
        rating,
        originalPrice,
        discountRate,
        discountPrice,
        brand
      ];

  Product copyWith({
    String? Id,
    String? name,
    String? summary,
    String? description,
    String? rating,
    String? originalPrice,
    String? discountPrice,
    String? discountRate,
    String? brand,
  }) {
    return Product(
      Id: Id ?? this.Id,
      name: name ?? this.name,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      discountRate: discountRate ?? this.discountRate,
      brand: brand ?? this.brand,
    );
  }
}
