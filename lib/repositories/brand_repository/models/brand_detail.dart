import 'package:aroundus_app/repositories/magazine_repository/models/magazine.dart';
import 'package:aroundus_app/repositories/product_repository/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_detail.g.dart';

@JsonSerializable()
class BrandDetail extends Equatable {
  const BrandDetail(this.Id, this.description, this.name, this.logo,
      this.magazines, this.products);

  final String? Id;
  final String? description;
  final String? name;
  final String? logo;
  final List? magazines;
  final List? products;

  factory BrandDetail.fromJson(Map<String, dynamic> json) =>
      _$BrandDetailFromJson(json);

  Map<String, dynamic> toJson() => _$BrandDetailToJson(this);

  @override
  List<Object?> get props => [Id, description, name, logo, magazines, products];
}
