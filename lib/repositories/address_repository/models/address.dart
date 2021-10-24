import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address extends Equatable {
  const Address(this.id,
      this.name,
      this.bigAddress,
      this.smallAddress,
      this.postalCode,
      this.phoneNumber,
      this.isDefault);

  final int id;
  final String name;
  final String bigAddress;
  final String smallAddress;
  final String postalCode;
  final String phoneNumber;
  final bool isDefault;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List<Object> get props =>
      [
        id,
        name,
        bigAddress,
        smallAddress,
        postalCode,
        phoneNumber,
        isDefault
      ];
}
