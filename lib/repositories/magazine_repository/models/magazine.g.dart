// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Magazine _$MagazineFromJson(Map<String, dynamic> json) {
  return Magazine(
    json['id'] as int?,
    json['title'] as String?,
    json['bannerImage'] as String?,
    (json['categories'] as List<dynamic>?)?.map((e) => e as String).toList(),
    json['content'] as String?,
  );
}

Map<String, dynamic> _$MagazineToJson(Magazine instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'categories': instance.categories,
      'bannerImage': instance.bannerImage,
      'content': instance.content,
    };
