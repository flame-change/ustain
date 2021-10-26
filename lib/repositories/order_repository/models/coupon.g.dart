// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  return Coupon(
    Id: json['Id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    expiresAt: json['expiresAt'] as String?,
    minPrice: json['minPrice'] as String?,
    discount: json['discount'] as String?,
  );
}

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'Id': instance.Id,
      'name': instance.name,
      'description': instance.description,
      'minPrice': instance.minPrice,
      'discount': instance.discount,
      'expiresAt': instance.expiresAt,
    };
