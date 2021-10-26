import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_requests.g.dart';

@JsonSerializable()
class CustomerRequests extends Equatable {
  const CustomerRequests(
    this.additionalRequest,
    this.shippingRequest,
  );

  final List<Map> shippingRequest;
  final String additionalRequest;

  factory CustomerRequests.fromJson(Map<String, dynamic> json) =>
      _$CustomerRequestsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRequestsToJson(this);

  @override
  List<Object> get props => [additionalRequest, shippingRequest];
}
