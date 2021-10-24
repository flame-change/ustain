import 'package:aroundus_app/repositories/address_repository/models/address.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends Equatable {
  const Order(
    this.products,
    this.address,
    this.request,
    this.coupon,
    this.agreed,
  );

  final List<OrderItem>? products;
  final Address? address;
  final CustomerRequests? request;
  final Coupon? coupon;
  final bool? agreed;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  List<Object?> get props => [
        products,
        address,
    request,
        coupon,
        agreed,
      ];
}
