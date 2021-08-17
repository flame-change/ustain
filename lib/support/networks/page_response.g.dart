// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponse _$PageResponseFromJson(Map<String, dynamic> json) {
  return PageResponse(
    count: json['count'] as int?,
    next: json['next'] as int?,
    previous: json['previous'] as int?,
    results: json['results'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$PageResponseToJson(PageResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'count': instance.count,
      'previous': instance.previous,
      'next': instance.next,
    };
