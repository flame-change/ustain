import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catalog.g.dart';

@JsonSerializable()
class Catalog extends Equatable {
  const Catalog(
      this.id, this.title, this.description, this.bannerImage, this.products);

  final int? id;
  final String? title;
  final String? description;
  final String? bannerImage;
  final List<Map>? products;

  factory Catalog.fromJson(Map<String, dynamic> json) =>
      _$CatalogFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogToJson(this);

  @override
  List<Object?> get props => [id, title, description, bannerImage, products];
}
