// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    Id: json['Id'] as String?,
    name: json['name'] as String?,
    summary: json['summary'] as String?,
    description: json['description'] as String?,
    rating: json['rating'] as String?,
    originalPrice: json['originalPrice'] as String?,
    discountPrice: json['discountPrice'] as String?,
    discountRate: json['discountRate'] as String?,
    brand: json['brand'] == null
        ? null
        : Brand.fromJson(json['brand'] as Map<String, dynamic>),
    thumbnail: json['thumbnail'] as String?,
    available: json['available'] as bool?,
    keywords: json['keywords'] as String?,
    socialValues: (json['socialValues'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    totalReviews: json['totalReviews'] as String?,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'Id': instance.Id,
      'name': instance.name,
      'summary': instance.summary,
      'description': instance.description,
      'rating': instance.rating,
      'originalPrice': instance.originalPrice,
      'discountPrice': instance.discountPrice,
      'discountRate': instance.discountRate,
      'brand': instance.brand,
      'keywords': instance.keywords,
      'available': instance.available,
      'thumbnail': instance.thumbnail,
      'socialValues': instance.socialValues,
      'totalReviews': instance.totalReviews,
    };
