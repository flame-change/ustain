import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'brand.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  const Product({
    this.Id,
    this.name,
    this.summary,
    this.description,
    this.rating,
    this.originalPrice,
    this.discountPrice,
    this.discountRate,
    this.brand,
    this.thumbnail,
    this.available,
    this.keywords,
    this.socialValues,
    this.totalReviews,
  });

  final String? Id;
  final String? name;
  final String? summary;
  final String? description;
  final String? rating;
  final String? originalPrice;
  final String? discountPrice;
  final String? discountRate;
  final Brand? brand;
  final String? keywords;
  final bool? available;
  final String? thumbnail;
  final List<String>? socialValues;
  final String? totalReviews;

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
        brand,
        thumbnail,
        available,
        keywords,
        socialValues,
        totalReviews,
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
    Brand? brand,
    String? thumbnail,
    String? keywords,
    bool? available,
    List<String>? socialValues,
    String? totalReviews,
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
      available: available ?? this.available,
      keywords: keywords ?? this.keywords,
      socialValues: socialValues ?? this.socialValues,
      totalReviews: totalReviews ?? this.totalReviews,
      brand: brand ?? this.brand,
    );
  }
}
