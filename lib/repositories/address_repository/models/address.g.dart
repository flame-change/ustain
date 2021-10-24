// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['id'] as int,
    json['name'] as String,
    json['bigAddress'] as String,
    json['smallAddress'] as String,
    json['postalCode'] as String,
    json['phoneNumber'] as String,
    json['isDefault'] as bool,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bigAddress': instance.bigAddress,
      'smallAddress': instance.smallAddress,
      'postalCode': instance.postalCode,
      'phoneNumber': instance.phoneNumber,
      'isDefault': instance.isDefault,
    };
