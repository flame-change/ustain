// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandDetail _$BrandDetailFromJson(Map<String, dynamic> json) {
  return BrandDetail(
    json['Id'] as String?,
    json['description'] as String?,
    json['name'] as String?,
    json['logo'] as String?,
    (json['magazines'] as List<dynamic>?)
        ?.map((e) => Magazine.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['products'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BrandDetailToJson(BrandDetail instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'description': instance.description,
      'name': instance.name,
      'logo': instance.logo,
      'magazines': instance.magazines,
      'products': instance.products,
    };
