// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    (json['products'] as List<dynamic>)
        .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    Address.fromJson(json['address'] as Map<String, dynamic>),
    CustomerRequests.fromJson(json['customerRequests'] as Map<String, dynamic>),
    Coupon.fromJson(json['coupon'] as Map<String, dynamic>),
    json['agreed'] as bool,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'products': instance.products,
      'address': instance.address,
      'customerRequests': instance.customerRequests,
      'coupon': instance.coupon,
      'agreed': instance.agreed,
    };
