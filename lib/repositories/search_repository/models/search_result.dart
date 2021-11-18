import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'search_result.g.dart';

@JsonSerializable()
class SearchResult extends Equatable {
  const SearchResult(this.keyword, this.magazines, this.brands, this.products);

  final String? keyword;
  final List? magazines;
  final List? products;
  final List? brands;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);

  @override
  List<Object?> get props => [keyword, products, magazines, products];
}
