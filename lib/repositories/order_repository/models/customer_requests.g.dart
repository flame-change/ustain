// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerRequests _$CustomerRequestsFromJson(Map<String, dynamic> json) {
  return CustomerRequests(
    json['additionalRequest'] as String,
    (json['shippingRequest'] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList(),
  );
}

Map<String, dynamic> _$CustomerRequestsToJson(CustomerRequests instance) =>
    <String, dynamic>{
      'shippingRequest': instance.shippingRequest,
      'additionalRequest': instance.additionalRequest,
    };
