// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return SearchResult(
    json['keyword'] as String?,
    json['magazines'] as List<dynamic>?,
    json['brands'] as List<dynamic>?,
    json['products'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'magazines': instance.magazines,
      'products': instance.products,
      'brands': instance.brands,
    };
