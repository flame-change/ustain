// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variants.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Variants _$VariantsFromJson(Map<String, dynamic> json) {
  return Variants(
    Id: json['Id'] as String?,
    name: json['name'] as String?,
    originalPrice: json['originalPrice'] as String?,
    discountPrice: json['discountPrice'] as String?,
    discountRate: json['discountRate'] as String?,
    available: json['available'] as bool?,
    thumbnail: json['thumbnail'] as String?,
    types: (json['types'] as List<dynamic>?)
        ?.map((e) => TypeGroup.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$VariantsToJson(Variants instance) => <String, dynamic>{
      'Id': instance.Id,
      'name': instance.name,
      'originalPrice': instance.originalPrice,
      'discountPrice': instance.discountPrice,
      'discountRate': instance.discountRate,
      'available': instance.available,
      'thumbnail': instance.thumbnail,
      'types': instance.types,
    };
